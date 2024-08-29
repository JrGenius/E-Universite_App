import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:webinar/app/providers/drawer_provider.dart';
import 'package:webinar/app/providers/page_provider.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/app/services/user_service/cart_service.dart';
import 'package:webinar/app/services/user_service/rewards_service.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/app/widgets/main_widget/main_drawer.dart';
import 'package:webinar/app/widgets/main_widget/main_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/common/database/app_database.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/locator.dart';

import '../../../common/enums/page_name_enum.dart';
import '../../../common/utils/object_instance.dart';
import '../../../config/assets.dart';
import '../../providers/app_language_provider.dart';



class MainPage extends StatefulWidget {
  static const String pageName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<int> future;

  double bottomNavHeight = 110;
  
  @override
  void initState() {
    super.initState();

    future = Future<int>(() {
      return 0;
    });

    FlutterNativeSplash.remove();
    locator<DrawerProvider>().isOpenDrawer = false;


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      
      AppDataBase.getCoursesAndSaveInDB();
      
      addListener();

      FirebaseMessaging.instance.getToken().then((value) {
        try{
          print('token : ${value}');
          UserService.sendFirebaseToken(value!);
        }catch(_){}
      });
    });

    getData();
  }


  getData(){

    CourseService.getReasons();

    AppData.getAccessToken().then((String value) {

      if(value.isNotEmpty){
        RewardsService.getRewards();
        CartService.getCart();
        UserService.getAllNotification();
      }
    });

  }

  @override
  void dispose() {
    drawerController.dispose();
    super.dispose();
  }

  addListener(){
    drawerController.addListener(() { 
      if(locator<DrawerProvider>().isOpenDrawer != drawerController.value.visible){

        Future.delayed(const Duration(milliseconds: 300)).then((value) {          
          if(mounted){
            locator<DrawerProvider>().setDrawerState(drawerController.value.visible);
          }
        });
      }
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    bottomNavHeight = 110;
    

    if( !kIsWeb ){
      if(Platform.isIOS){

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top
        ]);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (v){
        if(locator<PageProvider>().page == PageNames.home){
          MainWidget.showExitDialog();
        }else{
          locator<PageProvider>().setPage(PageNames.home);
        }
      },
      child: Consumer<AppLanguageProvider>(
        builder: (context, languageProvider, _) {
          
          drawerController = AdvancedDrawerController();
          if(locator<DrawerProvider>().isOpenDrawer){
            drawerController.showDrawer();
          }else{
            drawerController.hideDrawer();
          }
          
          addListener();
      
          return directionality(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: green77(),
              body: AdvancedDrawer(
                key: UniqueKey(),
                backdropColor: Colors.transparent,
      
                drawer: const MainDrawer(),
                
                openRatio: .6,
                openScale: .75,
                
                animationDuration: const Duration(milliseconds: 150),
                
                animateChildDecoration: false,
                animationCurve: Curves.linear,
      
                controller: drawerController,
                
                childDecoration: BoxDecoration(
                  // borderRadius: Platform.isIOS ? borderRadius() : const BorderRadius.vertical(top: Radius.circular(21)),
                  // borderRadius: kIsWeb ? null : borderRadius(radius: isOpen ? 20 : 0),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.12),
                      blurRadius: 30,
                      offset: const Offset(0, 10)
                    )
                  ]
                ),
      
                rtlOpening: locator<AppLanguage>().isRtl(),
                
                // background
                backdrop: Container(
                  width: getSize().width,
                  height: getSize().height,
                  color: green63,
      
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(AppAssets.splashPng),
                  //     fit: BoxFit.cover,
                  //   )
                  // ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      space(60),

                      Image.asset(AppAssets.worldPng,width: getSize().width * .8, fit: BoxFit.cover,),
                    ],
                  ),
                ),
      
                child: Consumer<PageProvider>(
                  builder: (context, pageProvider, _) {
                    return SafeArea(
                      bottom: !kIsWeb && Platform.isAndroid,
                      top: false,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        resizeToAvoidBottomInset: false,
                        extendBody: true,
      
                        body: pageProvider.pages[pageProvider.page],
                    
      
                        bottomNavigationBar: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Consumer<DrawerProvider>(
                            builder: (context, drawerProvider, _) {
                              return Stack(
                                children: [
                                  
                                  // background
                                  Positioned.fill(
                                    bottom: 0,
                                    top: getSize().height - bottomNavHeight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: drawerProvider.isOpenDrawer ? const Radius.circular(kIsWeb ? 0 : 20) : Radius.zero
                                      ),
                                      child: ClipPath(
                                        clipper: BottomNavClipper(),
                                                                      
                                        child: Container(
                                          width: getSize().width,
                                          height: bottomNavHeight,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                green77(),
                                                green4B
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight
                                            )
                                          ),
                                        ),
                                                                      
                                                                      
                                      ),
                                    ),
                                  ),
                                                
                                  Positioned.fill(
                                    bottom: 0,
                                    top: getSize().height - bottomNavHeight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        
                                        MainWidget.navItem(PageNames.categories, pageProvider.page, appText.categories, AppAssets.categorySvg, (){
                                          pageProvider.setPage(PageNames.categories);
                                        }),
                                        
                                        MainWidget.navItem(PageNames.providers, pageProvider.page, appText.providers, AppAssets.provideresSvg, (){
                                          pageProvider.setPage(PageNames.providers);
                                        }),
                                                
                                                
                                        MainWidget.homeNavItem(PageNames.home, pageProvider.page, (){
                                          pageProvider.setPage(PageNames.home);
                                        }),
                                        
                                        
                                        MainWidget.navItem(PageNames.blog, pageProvider.page, appText.blog, AppAssets.blogSvg, (){
                                          pageProvider.setPage(PageNames.blog);
                                        }),
                                        
                                        MainWidget.navItem(PageNames.myClasses, pageProvider.page, appText.myClassess, AppAssets.classesSvg, (){
                                          pageProvider.setPage(PageNames.myClasses);
                                        }),
                                                
                                      ],
                                    )
                                  )
                                ],
                              );
                            }
                          ),
                        ),
                    
                      ),
                    );
                  }
                )
              ),
            )
          );
        }
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    
    double height = size.height;
    double width = size.width;

    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(width, height);

    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      width, 
      45, 
      width - 45,
      45
    );
    
    path.lineTo(45, 45);

    path.quadraticBezierTo(
      0, 
      45, 
      0,
      0
    );

    // path.moveTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
  
}
