
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../common/data/app_language.dart';
import '../../../../../../common/utils/constants.dart';
import '../../../../../../locator.dart';

class WebViewPage extends StatefulWidget {
  static const String pageName = '/web-view';
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
 
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(

    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
    mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
    
    cacheEnabled: true,
    javaScriptEnabled: true,
    
    useHybridComposition: false,
    sharedCookiesEnabled: true,
    
    useShouldOverrideUrlLoading: true,
    useOnLoadResource: false,


  );

  CookieManager cookieManager = CookieManager.instance();

  String? url;
  String? title;

  late WebViewController controller;
  bool isShow=false;

  bool isSendTokenInHeader=true;
  LoadRequestMethod method = LoadRequestMethod.post;

  PlatformWebViewControllerCreationParams params = const PlatformWebViewControllerCreationParams();
  String token = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      url = (ModalRoute.of(context)!.settings.arguments as List)[0];
      title = (ModalRoute.of(context)!.settings.arguments as List)[1] ?? '';

      try{
        isSendTokenInHeader = (ModalRoute.of(context)!.settings.arguments as List)[2] ?? true;
      }catch(_){}
      
      try{
        method = (ModalRoute.of(context)!.settings.arguments as List)[3] ?? LoadRequestMethod.post;
      }catch(_){}

      token = await AppData.getAccessToken();
      
      if(token.isNotEmpty){
        cookieManager.setCookie(
          url: WebUri(url!),
          name: 'XSRF-TOKEN', 
          value: token,
          domain: Constants.dommain.replaceAll('https://', ''),
          isHttpOnly: true,
          isSecure: true,
          path: '/',
          expiresDate: DateTime.now().add(const Duration(hours: 2)).millisecondsSinceEpoch,
        );
        
        cookieManager.setCookie(
          url: WebUri(url!),
          name: 'webinar_session', 
          value: token,
          domain: Constants.dommain.replaceAll('https://', ''),
          isHttpOnly: true,
          isSecure: true,
          path: '/',
          expiresDate: DateTime.now().add(const Duration(hours: 2)).millisecondsSinceEpoch,
          sameSite: HTTPCookieSameSitePolicy.LAX
        );
      }

      isShow = true;
      setState(() {});
      
      await [
        Permission.camera,
        Permission.microphone,
      ].request();

      setState(() {});


    });
  }



  load() async {
    var header = {
      if(isSendTokenInHeader)...{
        "Authorization": "Bearer $token",
      },
      "Content-Type" : "application/json", 
      'Accept' : 'application/json',
      'x-api-key' : Constants.apiKey,
      'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
    };

    if( !(url?.startsWith('http') ?? false) ){

      await webViewController?.loadData(
        data: url ?? '', 
        baseUrl: null, 
        historyUrl: null, 
      );

    }else{
      await webViewController?.loadUrl(
        urlRequest: URLRequest(
          method: method == LoadRequestMethod.post ? "POST" : "GET",
          url: WebUri(url ?? ''),
          headers: header,
        ),
      );

    }
  }



  @override
  Widget build(BuildContext context) {

    return directionality(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            appBar: appbar(title: title ?? ''),
          
            body: isShow
          ? InAppWebView(
          
              onJsBeforeUnload: (nAppWebViewController, jsBeforeUnloadRequest)async{
                return JsBeforeUnloadResponse();
              },
          
              key: webViewKey,
              initialSettings: settings,
          
              onReceivedHttpError: (inAppWebViewController, webResourceRequest, webResourceResponse ){
                
                // print('EEE : ${webResourceRequest.url}');
                // print('EEE : ${webResourceResponse.statusCode}');
                // print('EEE : ${webResourceResponse.reasonPhrase}');
                // print('EEE : ${webResourceResponse.contentEncoding}');
          
                // // authentication error. reload url
                // if(webResourceResponse.statusCode == 500 && webResourceResponse.contentEncoding == 'utf-8'){
                //   url = webResourceRequest.url.toString();
                //   // load();
                // }
                
              },
          
          
              onWebViewCreated: (controller) async {
                webViewController = controller;
                
                load();
              },
          
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT
                );
              },
              
              onLoadResource: (inAppWebViewController, loadedResource){
                // print("onLoadResource: $loadedResource");
              },
              
              shouldOverrideUrlLoading: (controller, navigationAction) async {
          
                // print("url::  ${navigationAction.request.url}");
                // url = navigationAction.request.url?.path ?? url;
          
          
                if(isSendTokenInHeader){
                  if(!(navigationAction.request.headers?.containsKey('Authorization') ?? false)){
                    if(navigationAction.request.headers != null){
                      
                      navigationAction.request.headers?.addAll({"Authorization": "Bearer $token",});
                      controller.loadUrl(urlRequest: navigationAction.request);
                      return NavigationActionPolicy.ALLOW;
                    }
                  }
                }
          
          
                var header = {
                  if(isSendTokenInHeader)...{
                    "Authorization": "Bearer $token",
                  },
                  "Content-Type" : "application/json", 
                  'Accept' : 'application/json',
                  'x-api-key' : Constants.apiKey,
                  'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
                };
          
                if(navigationAction.request.headers == null || (navigationAction.request.headers?.isEmpty ?? true)){
          
                  navigationAction.request.headers = header;
                  controller.loadUrl(urlRequest: navigationAction.request);
          
                  return NavigationActionPolicy.ALLOW;
                }
          
          
                return NavigationActionPolicy.ALLOW;
                
              },
              onLoadStop: (controller, url) async {
          
              },
              onReceivedError: (controller, request, error) {},
              onProgressChanged: (controller, progress) {
                if (progress == 100) {}
                setState(() {});
              },
          
              onUpdateVisitedHistory: (controller, uri, isReload) {
                
              },
          
              onConsoleMessage: (controller, consoleMessage) {},
              
              onNavigationResponse: (cntr, n)async{
                return NavigationResponseAction.ALLOW;
              },
              
            )
            : loading(),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    webViewController?.dispose();
    super.dispose();
  }
}