import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webinar/app/models/saas_package_model.dart';
import 'package:webinar/app/pages/main_page/home_page/payment_status_page/payment_status_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/subscription_service.dart';
import 'package:webinar/app/widgets/main_widget/subscription_widget/subscription_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/locator.dart';

import '../../../../models/subscription_model.dart';

class SubscriptionPage extends StatefulWidget {
  static const String pageName = '/subscriptions';
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> with SingleTickerProviderStateMixin{

  bool isLoading = false;
  SubscriptionModel? data;
  SaasPackageModel? saasPackageData;

  PageController pageController = PageController();
  int currentSubscriptionPage = 0;
  
  PageController saasPageController = PageController();
  int currentSaaSPackagePage = 0;

  late TabController tabController;

  bool isLoadingSubscription = false;
  bool isLoadingSaasPackage = false;

  late StreamSubscription _sub;


  @override
  void initState() {
    super.initState();

    if(locator<UserProvider>().profile?.roleName != 'user'){
      tabController = TabController(length: 2, vsync: this);
    }else{
      tabController = TabController(length: 1, vsync: this);
    }
    
    getData();
    initUniLinks();

  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    
    data = await SubscriptionService.getSubscription();
    
    if(locator<UserProvider>().profile?.roleName != 'user'){
      saasPackageData = await SubscriptionService.getSaasPackages();
    }
    
    setState(() {
      isLoading = false;
    });
    
  }

  Future<void> initUniLinks() async {

    _sub = linkStream.listen((String? link) {
      if(link != null){
        
        if(link == '${Constants.scheme}://payment-success'){
          getData();
          nextRoute(PaymentStatusPage.pageName, arguments: 'success');
        }else if(link == '${Constants.scheme}://payment-failed'){
          nextRoute(PaymentStatusPage.pageName, arguments: 'failed');
        }

      }
    }, onError: (err) {});
    
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.subscription),

        body: isLoading 
      ? loading()
      : Column(
          children: [

            tabBar(
              (p0) => null, 
              tabController, 
              [
                Tab(text: appText.subscription, height: 32),

                if(locator<UserProvider>().profile?.roleName != 'user')...{
                  Tab(text: appText.saaSPackages, height: 32),
                }
                
              ]
            ),

            space(6),

            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: [

                  SubscriptionWidget.subscriptionPage(
                    pageController, 
                    data!, 
                    currentSubscriptionPage, 
                    (i) {
                      setState(() {
                        currentSubscriptionPage = i;
                      });
                    },
                    isLoadingSubscription,
                    (int id) async {
                      setState(() {
                        isLoadingSubscription = true;
                      });
                      
                      String? link = await SubscriptionService.getSubscriptionLink(id);

                      setState(() {
                        isLoadingSubscription = false;
                      });

                      if(link != null){
                        String token = await AppData.getAccessToken();

                        Map<String, String> headers = {
                          "Authorization": "Bearer $token",
                          "Content-Type" : "application/json", 
                          'Accept' : 'application/json',
                          'x-api-key' : Constants.apiKey,
                          'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
                        };

                        await launchUrlString(
                          link,
                          mode: LaunchMode.externalApplication,
                          webViewConfiguration: WebViewConfiguration(
                            headers: headers,
                          )
                        );
                      }
                    }
                  ),

                  if(locator<UserProvider>().profile?.roleName != 'user')...{
                    SubscriptionWidget.saasPackagePage(
                      saasPageController, 
                      saasPackageData, 
                      currentSaaSPackagePage, 
                      (i) {
                        setState(() {
                          currentSaaSPackagePage = i;
                        });
                      },
                      
                      isLoadingSaasPackage,
                      (int id) async {
                        setState(() {
                          isLoadingSaasPackage = true;
                        });
                        
                        String? link = await SubscriptionService.getSaasPackageLink(id);

                        setState(() {
                          isLoadingSaasPackage = false;
                        });

                        if(link != null){
                          String token = await AppData.getAccessToken();

                          Map<String, String> headers = {
                            "Authorization": "Bearer $token",
                            "Content-Type" : "application/json", 
                            'Accept' : 'application/json',
                            'x-api-key' : Constants.apiKey,
                            'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
                          };

                          await launchUrlString(
                            link,
                            mode: LaunchMode.externalApplication,
                            webViewConfiguration: WebViewConfiguration(
                              headers: headers,
                            )
                          );
                        }
                      }

                    ),

                  }

                ]
              )
            ),

          ],
        )
      )
    );
  }
}