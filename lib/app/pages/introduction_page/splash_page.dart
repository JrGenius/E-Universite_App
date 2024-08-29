import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:webinar/app/pages/introduction_page/intro_page.dart';
import 'package:webinar/app/pages/main_page/main_page.dart';
import 'package:webinar/app/pages/offline_page/internet_connection_page.dart';
import 'package:webinar/app/services/guest_service/guest_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/styles.dart';

class SplashPage extends StatefulWidget {
  static const String pageName = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));

    FlutterNativeSplash.remove();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      animationController.forward();
      
      Timer(const Duration(seconds: 3), () async {

        final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
        
        if(connectivityResult.contains(ConnectivityResult.none)){
          nextRoute(InternetConnectionPage.pageName, isClearBackRoutes: true);
        }else{
          String token = await AppData.getAccessToken();

          if(mounted){
            if(token.isEmpty){
              bool isFirst = await AppData.getIsFirst(); 

              if(isFirst){
                nextRoute(IntroPage.pageName, isClearBackRoutes: true);
              }else{
                nextRoute(MainPage.pageName, isClearBackRoutes: true);
              }
            }else{
              nextRoute(MainPage.pageName, isClearBackRoutes: true);
            }
          }
        }
        

      });
    });

    GuestService.config();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00BA63),
      body: Container(
        width: getSize().width,
        height: getSize().height,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashPng),
            fit: BoxFit.cover,
          )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Spacer(),const Spacer(),

            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: AnimatedBuilder(
                    animation: animationController,
                  
                    builder: (content, _){
                      return Transform.rotate(
                        angle: animationController.value * .5 * 3.14,
                        child: SvgPicture.asset(
                          AppAssets.whiteLogoEmptySvg,
                        ),
                      );
                    }
                  ),
                ),

                Center(
                  child: SvgPicture.asset(AppAssets.logoLineSvg),
                ),
              ],
            ),

            space(40),

            Text(
              appText.webinar,
              style: style24Bold().copyWith(color: Colors.white),
            ),

            space(10),

            Text(
              appText.splashDesc,
              style: style16Regular().copyWith(color: Colors.white),
            ),
            const Spacer(),const Spacer(),


            const SizedBox(
              width: 35,
              child: LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                colors: [Colors.white],
                strokeWidth: 100,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.transparent,
            
              ),
            ),

            const Spacer(),


          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}