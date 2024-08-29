import 'package:flutter/material.dart';
import 'package:webinar/app/pages/main_page/main_page.dart';
import 'package:webinar/app/widgets/introduction_widget/intro_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';

class IntroPage extends StatefulWidget {
  static const String pageName = '/intro';
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {


  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    AppData.saveIsFirst(false);
  }

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(
        body: Stack(
          children: [

            Positioned.fill(
              child: Image.asset(
                AppAssets.introBgPng,
                width: getSize().width,
                height: getSize().height,
                fit: BoxFit.cover,
              )
            ),

            Positioned.fill(
              child: PageView(
                controller: pageController,
                onPageChanged: (i){
                  setState(() {
                    currentPage = i;
                  });
                },
                physics: const CustomPageViewScrollPhysics(),
                children: [

                  IntroWidget.item(AppAssets.onboarding1Json, appText.introTitle1, appText.introDesc1, page: 1),
 
                  IntroWidget.item(AppAssets.onboarding2Json, appText.introTitle2, appText.introDesc2, page: 2),
 
                  IntroWidget.item(AppAssets.onboarding3Json, appText.introTitle3, appText.introDesc3, page: 3),
 
                  IntroWidget.item(AppAssets.loginJson, appText.introTitle4, appText.introDesc4, page: 4),


                ],
              )
            ),

            Positioned(
              bottom: 20,
              right: 30,
              left: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: (){
                      nextRoute(MainPage.pageName, isClearBackRoutes: true);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      appText.skip,
                    ),
                  ),

                  // indecator
                  Row(
                    children: List.generate(4, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: padding(horizontal: 1.5),
                        width: 6,
                        height: 6,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index ? green77() : greyA5.withOpacity(.5)
                        ),
                      );
                    }),
                  ),

                  GestureDetector(
                    onTap: (){

                      if(currentPage == 3){
                        nextRoute(MainPage.pageName, isClearBackRoutes: true);
                      }else{
                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      appText.next,
                    ),
                  ),
                  
                ],
              )
            ),
          ],
        )
      )
    );
  }
}