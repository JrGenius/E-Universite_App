import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webinar/app/pages/main_page/home_page/notification_page.dart';
import 'package:webinar/app/pages/main_page/home_page/search_page/suggested_search_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/authentication_service/authentication_service.dart';
import 'package:webinar/common/components.dart';

import '../../../../common/common.dart';
import '../../../../common/utils/app_text.dart';
import '../../../../common/utils/object_instance.dart';
import '../../../../config/assets.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../pages/main_page/home_page/cart_page/cart_page.dart';
import '../main_widget.dart';





class HomeWidget{

  static Widget homeAppBar(AnimationController appBarController, Animation appBarAnimation,String token,TextEditingController searchController,FocusNode searchNode,String name){
    return AnimatedBuilder(
      animation: appBarAnimation,
      builder: (context, child) {

        return Consumer<UserProvider>(
          builder: (context,userProvider,_) {

            return Container(
              width: getSize().width,
              height: appBarAnimation.value,
              decoration: BoxDecoration(
                color: green77(),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28)
                )
              ),

              child: Stack(
                children: [
                  
                  PositionedDirectional(
                    bottom: 0,
                    
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: SvgPicture.asset(
                        AppAssets.appbarLineSvg,
                        width: getSize().width,
                      ),
                    )
                  ),

                  Positioned.fill(
                    child: Padding(
                      padding: padding(),
                      child: Column(
                        children: [
                    
                          // app bar
                          Container(
                            
                            width: getSize().width,
                            margin: EdgeInsets.only(top: (!kIsWeb && Platform.isIOS) ? MediaQuery.of(context).viewPadding.top + 16 : MediaQuery.of(context).viewPadding.top + 22),
                            child: Row(
                              children: [
                    
                                // menu 
                                GestureDetector(
                                  onTap: () async {
                                    
                                    drawerController.showDrawer();
                                    
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(AppAssets.menuSvg),
                                  ),
                                ),
                    
                                space(0,width: 4),
                    
                                // title
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                                              
                                      // username
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: getSize().width * .4,
                                              minWidth: getSize().width * .1
                                            ),
                                            child: Text(
                                              token.isEmpty
                                              ? appText.webinar
                                              : '${appText.hi} $name ',
                                              style: style20Bold().copyWith(color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                                                  
                                          if(token.isNotEmpty)...{
                                            SvgPicture.asset(AppAssets.hiSvg),
                                          }
                                        ],
                                      ),
                                                              
                                      Text(
                                        appText.letsStartLearning,
                                        style: style14Regular().copyWith(color: Colors.white, height: 1),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                    
                                // basket and notification
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    
                                    // basket
                                    MainWidget.menuButton(
                                      AppAssets.basketSvg, 
                                      userProvider.cartData?.items?.isNotEmpty ?? false, 
                                      Colors.white, 
                                      Colors.black.withOpacity(.2), 
                                      (){ 
                                        nextRoute(CartPage.pageName);
                                      }
                                    ),
                    
                                    space(0,width: 12),
                    
                                    // notification
                                    MainWidget.menuButton(
                                      AppAssets.notificationSvg, 
                                      userProvider.notification.where((element) => element.status == 'unread').isNotEmpty,
                                      Colors.white, 
                                      Colors.black.withOpacity(.2), 
                                      (){
                                        nextRoute(NotificationPage.pageName);
                                      }
                                    )
                                  ],
                                )
                    
                    
                              ],
                            ),
                          ),
                          
                          const Spacer(),
                    
                          AnimatedCrossFade(
                            firstChild: Column(
                              children: [
                    
                                input(searchController, searchNode, appText.searchInputDesc,iconPathLeft: AppAssets.searchSvg,isReadOnly: true,onTap: (){
                                  nextRoute(SuggestedSearchPage.pageName);
                                }),
                                
                                space(16)
                              ],
                            ), 
                            secondChild: SizedBox(width: getSize().width), 
                             
                            crossFadeState: (appBarAnimation.value < (150 + MediaQuery.of(navigatorKey.currentContext!).viewPadding.top)) 
                              ? CrossFadeState.showSecond 
                              : CrossFadeState.showFirst,

                            duration: const Duration(milliseconds: 200), 
                          )
                        ],
                      ),
                    )
                  )
              ],
            ),
      
            );
          }
        );
      }
    );
  }


  static Widget titleAndMore(String title,{bool isViewAll=true,Function? onTapViewAll}){
    return Padding(
      padding: padding(vertical: 16),
      child: Row(
        children: [
          
          Text(
            title,
            style: style20Bold(),
          ),

          const Spacer(),

          if(isViewAll)...{
            GestureDetector(
              onTap: (){
                if(onTapViewAll != null){
                  onTapViewAll();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Text(
                appText.viewAll,
                style: style14Regular().copyWith(color: greyA5),
              ),
            )
          }

        ],
      ),
    );
  }


  static Future showFinalizeRegister(int userId) async {

    TextEditingController nameController = TextEditingController();
    FocusNode nameNode = FocusNode();

    TextEditingController referralController = TextEditingController();
    FocusNode referralNode = FocusNode();

    bool isLoading = false;

    return await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: navigatorKey.currentContext!, 
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {

            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  directionality(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom
                      ),
                      width: getSize().width,
                      padding: padding(vertical: 21),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                      ),
                  
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            appText.finalizeYourAccount,
                            style: style16Bold(),
                          ),
                  
                          space(16),
                  
                          input(nameController, nameNode, appText.yourName, iconPathLeft: AppAssets.profileSvg, leftIconSize: 14,isBorder: true),
                          
                          space(16),
                  
                          input(referralController, referralNode, appText.refCode, iconPathLeft: AppAssets.ticketSvg, leftIconSize: 14,isBorder: true),
                          
                          space(24),
            
                          Center(
                            child: button(
                              onTap: () async {
                                if(nameController.text.length > 3){
                                  setState((){
                                    isLoading = true;
                                  });
                                  
                                  bool res = await AuthenticationService.registerStep3(
                                    userId, 
                                    nameController.text.trim(), 
                                    referralController.text.trim()
                                  );
            
                                  if(res){
                                    backRoute(arguments: res);
                                  }
                                  
                                  setState((){
                                    isLoading = false;
                                  });
                                }
                              }, 
                              width: getSize().width, 
                              height: 52, 
                              text: appText.continue_, 
                              bgColor: green77(), 
                              textColor: Colors.white, 
                              isLoading: isLoading
                            ),
                          ),
            
                          space(24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

          },
        );
      },
    );
  }
}