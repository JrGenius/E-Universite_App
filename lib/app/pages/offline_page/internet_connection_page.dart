import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/pages/introduction_page/splash_page.dart';
import 'package:webinar/app/pages/offline_page/offline_list_course_page.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class InternetConnectionPage extends StatefulWidget {
  static const String pageName = '/internet-connection';
  const InternetConnectionPage({super.key});

  @override
  State<InternetConnectionPage> createState() => _InternetConnectionPageState();
}

class _InternetConnectionPageState extends State<InternetConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          space(0,width: getSize().width),

          const Spacer(),
          
          SvgPicture.asset(AppAssets.notFoundEmptyStateSvg),

          Text(
            appText.networkProblem,
            style: style16Bold().copyWith(fontSize: 18),
          ),

          space(10),

          Text(
            appText.networkProblemDesc,
            style: style14Regular(),
          ),

          space(20),

          button(
            onTap: () async {
              nextRoute(SplashPage.pageName, isClearBackRoutes: true);
            },
            width: getSize().width * .55, 
            height: 52, 
            text: appText.retry, 
            bgColor: green77(), 
            textColor: Colors.white
          ),

          const Spacer(),

          // my courses
          Container(
            width: getSize().width,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 30
            ),
          
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                boxShadow(Colors.black.withOpacity(.1),blur: 15,y: -3)
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
            ),
            child: button(
              onTap: () async {
                nextRoute(OfflineListCoursePage.pageName);
              },
              width: getSize().width, 
              height: 52, 
              text: appText.myCourses, 
              bgColor: green77(), 
              textColor: Colors.white
            ),
          ),



        ],
      ),
    );
  }
}