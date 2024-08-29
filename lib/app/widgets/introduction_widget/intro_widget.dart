import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webinar/app/pages/authentication_page/login_page.dart';
import 'package:webinar/app/pages/authentication_page/register_page.dart';
import 'package:webinar/app/pages/main_page/main_page.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/styles.dart';

import '../../../config/colors.dart';

class IntroWidget{

  static Widget item(String path,String title, String desc,{int page=1}){
    return Padding(
      padding: padding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          space(getSize().height * .2),
          
          Lottie.asset(path, repeat: true, width: getSize().width * .6),
    
          space(20),
    
          Text(
            title,
            style: style24Bold(),
          ),
    
          space(12),
          
          Padding(
            padding: padding(horizontal: 40),
            child: Text(
              desc,
              style: style16Regular().copyWith(color: grey5E),
              textAlign: TextAlign.center,
            ),
          ),


          if(page == 3)...{

            space(getSize().height * .1),
            
            button(
              onTap: (){
                nextRoute(MainPage.pageName,isClearBackRoutes: true);
              }, 
              width: getSize().width * .4, 
              height: 52, 
              text: appText.getStart,
              bgColor: green77(), 
              textColor: Colors.white, 
              borderColor: Colors.transparent,
              boxShadow: boxShadow(green77().withOpacity(.3)),
              raduis: 15
            )
          }else if(page == 4)...{ 
            space(getSize().height * .1),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: button(
                    onTap: (){
                      nextRoute(LoginPage.pageName,isClearBackRoutes: true);
                    }, 
                    width: getSize().width, 
                    height: 52, 
                    text: appText.login,
                    bgColor: green77(), 
                    textColor: Colors.white, 
                    borderColor: Colors.transparent,
                    boxShadow: boxShadow(green77().withOpacity(.3)),
                    raduis: 15
                  ),
                ),
                
                space(0,width: 20),

                Expanded(
                  child: button(
                    onTap: (){
                      nextRoute(RegisterPage.pageName,isClearBackRoutes: true);
                    }, 
                    width: getSize().width, 
                    height: 52, 
                    text: appText.signup,
                    bgColor: Colors.white, 
                    textColor: green77(), 
                    borderColor: green77(),
                    raduis: 15
                  ),
                ),
              ],
            ),


            const Spacer(),

            // // skipLogin
            // GestureDetector(
            //   onTap: (){
            //     nextRoute(MainPage.pageName,isClearBackRoutes: true);
            //   },
            //   behavior: HitTestBehavior.opaque,
            //   child: Text(
            //     appText.skipLogin,
            //     style: style16Regular(),
            //   ),
            // ),

            // ignore: equal_elements_in_set
            const Spacer(flex: 1,),
          
          
          }
        ],
      ),
    );
  }


}