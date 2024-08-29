import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/pages/main_page/categories_page/categories_page.dart';
import 'package:webinar/app/pages/offline_page/offline_single_content_page.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/database/app_database.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';

class OfflineSingleCoursePage extends StatefulWidget {
  static const String pageName = '/offline-single-course';
  const OfflineSingleCoursePage({super.key});

  @override
  State<OfflineSingleCoursePage> createState() => _OfflineSingleCoursePageState();
}

class _OfflineSingleCoursePageState extends State<OfflineSingleCoursePage> with SingleTickerProviderStateMixin{


  CourseModel? course;
  List<ContentModel> contents = [];

  late TabController tabController;

  bool viewMore = false;


  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      
      course = ModalRoute.of(context)!.settings.arguments as CourseModel;
      contents = await AppDataBase.getContentsCoursesAtDB(course!.id!);
      
      getSingleContentData();
      setState(() {});
    });

  }


  Future getSingleContentData()async{

  }

  @override
  Widget build(BuildContext context) {

    

    return directionality(
      child: Scaffold(
        appBar: appbar(title: course?.title ?? ''),

        body: Column(
          children: [

            // tab bar
            tabBar((p0) {}, tabController, [
              Tab(text: appText.information, height: 32,),
              Tab(text: appText.content, height: 32,),
            ]),


            // body
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  
                  informationTab(),

                  contentTab(contents, course?.id ?? 0),
                ]
              )
            )
          ],
        ),
      ),
    );
  }

  Widget informationTab(){
    
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(),
      child: Column(
        children: [

          space(15),

          Container(
            height: viewMore ? null : 250,

            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: viewMore
                ? [Colors.white.withOpacity(0), Colors.white.withOpacity(0)]
                : [
                  Colors.white.withOpacity(.9), 
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,

              ),
            ),

            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: HtmlWidget(
                course?.description ?? '',
              ),
            ),
          ),

          if(viewMore)...{
            space(5),
          }else...{

            Stack(
              children: [

                // white bg
                Container(
                  width: getSize().width,
                  height: 15,
                  color: Colors.white,
                ),

                Center(
                  child: button(
                    onTap: (){
                      setState(() {
                        viewMore = true;
                      });
                    }, 
                    width: 88, 
                    height: 30, 
                    text: appText.viewMore, 
                    bgColor: Colors.white, 
                    textColor: greyA5
                  ),
                ),

              ],
            )
          },


          space(30),

          // info   
          Container(
            padding: padding(),
            width: getSize().width,
            alignment: Alignment.center,
            child: Wrap(              
              runSpacing: 21,
              children: [
          
                SingleCourseWidget.courseStatus(
                  appText.students, 
                  course?.salesCountNumber?.toString() ?? course?.studentsCount?.toString() ?? '0', 
                  AppAssets.profileSvg,
                  width: (getSize().width * .5) - 42,
                ),
          
                if(course?.type == 'course')...{
                  SingleCourseWidget.courseStatus(
                    appText.chapters, 
                    contents.length.toString(), 
                    AppAssets.moreSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },

                if(course?.createdAt != null)...{
                  SingleCourseWidget.courseStatus(
                    appText.publishDate, 
                    timeStampToDate((course?.createdAt ?? 0) * 1000).toString(), 
                    AppAssets.calendarSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },
                
                SingleCourseWidget.courseStatus(
                  appText.duration, 
                  "${durationToString(course?.duration ?? 0)} ${appText.hours}", 
                  AppAssets.timeCircleSvg,
                  width: (getSize().width * .5) - 42,
                ),


                if(course?.capacity != null)...{
                  SingleCourseWidget.courseStatus(
                    appText.capacity, 
                    course?.capacity?.toString() ?? '', 
                    AppAssets.provideresSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },

                SingleCourseWidget.courseStatus(
                  appText.type, 
                  course?.type ?? '', 
                  AppAssets.videoSvg,
                  width: (getSize().width * .5) - 42,
                ),
                
                SingleCourseWidget.courseStatus(
                  appText.status, 
                  course?.status ?? '', 
                  AppAssets.moreSvg,
                  width: (getSize().width * .5) - 42,
                ),
          
              ],  
            ),
          ),
          
          
          space(28),


        ],
      ),
    );
  }



  Widget contentTab(List<ContentModel> contents,int courseId){
    
    if(contents.isEmpty) {
      return const SizedBox();
    }


    String iconType(ContentItem item){

      switch (item.type) {
        case 'quiz':
          return AppAssets.shieldSvg;
        
        case 'text_lesson':
        case 'assignment':
          return AppAssets.documentSvg;
        
        case 'file':
          return item.downloadable == 1 ? AppAssets.paperDownloadSvg : AppAssets.videoSvg;
        
        default:
          return AppAssets.videoSvg;
      }
    }
    
    String subTitleType(ContentItem item){

      switch (item.type) {
        case 'quiz':
          return '${item.questionCount ?? 0} ${appText.questions} | ${item.time ?? 0} ${appText.min}';
        
        case 'text_lesson':
          return item.summary ?? '';
        
        case 'file':
          return item.volume ?? '';

        case 'session':
          return "${timeStampToDate((item.date ?? 0) * 1000 )} | ${DateTime.fromMillisecondsSinceEpoch((item.date ?? 0) * 1000 ).toString().split(' ').last.substring(0,5) }";
        
        default:
          return item.volume ?? '';
      }
    }
    
    Color colorType(ContentItem item){

      switch (item.type) {
        case 'quiz':
          return cyan50;

        case 'text_lesson':
          return yellow29;
      
        case 'file':
          return green50;
        
        case 'session':
          return blueFE;
        
        case 'assignment':
          return blueA4;
        
        default:
          return green50;
      }
    }
    
    int sizeType(ContentItem item){

      switch (item.type) {
        case 'quiz':
          return 24;

        case 'text_lesson':
          return 20;
      
        case 'file':
          return item.downloadable == 1 ? 24 : 18;
        
        case 'session':
          return 18;
        
        case 'assignment':
          return 22;
        
        default:
          return 24;
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(),
      child: Column(
        children: [
        
          space(8),
        
          // filesChapters 
          ...List.generate(contents.length, (index) {
            return Container(
              width: getSize().width,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius(radius: 15)
              ),
              clipBehavior: Clip.none,
              child: Column(
                children: [

                  // chapters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Expanded(
                        child: horizontalChapterItem(
                          green77(), 
                          AppAssets.categorySvg, 
                          contents[index].title ?? '', '${contents[index].items?.length ?? 0} ${appText.lessons}', 
                          (){
                            contents[index].isOpen = !(contents[index].isOpen);
                            setState(() {});
                          },
                          transparentColor: true,
                          isFixWidth: true
                        ),
                      ),
    
                      space(0,width: 12),
                      
                      SvgPicture.asset(
                        (contents[index].isOpen) ? AppAssets.arrowUpSvg : AppAssets.arrowDownSvg,
                      ),
    
                      space(0,width: 12),
                    ],
                  ),

                  // items
                  AnimatedCrossFade(
                    firstChild: SizedBox(width: getSize().width), 
                    secondChild: Stack(
                      clipBehavior: Clip.none,
                      children: [

                        // vertical dash
                        PositionedDirectional(
                          start: 40,
                          top: 25,
                          bottom: 35,
                          child: CustomPaint(
                            size: const Size(.5, double.infinity),
                            painter: DashedLineVerticalPainter(),
                            child: const SizedBox(),
                          ),
                        ),

                        // content
                        Column(
                          children: [
    
                            ...List.generate(contents[index].items?.length ?? 0, (i) {
                              return horizontalChapterItem(
                                colorType(contents[index].items![i]),
                                iconType(contents[index].items![i]),

                                contents[index].items?[i].title ?? '', 

                                subTitleType(contents[index].items![i]),

                                () async {

                                  nextRoute(OfflineSingleContentPage.pageName, arguments: [courseId ,contents[index].items![i]]);
                               
                                },
                                height: sizeType(contents[index].items![i]).toDouble(),
                                transparentColor: true,
                                isFixWidth: true
                              );
                            }),
                          ],
                        ),
                      ],
                    ), 
                    crossFadeState: (contents[index].isOpen) ? CrossFadeState.showSecond : CrossFadeState.showFirst, 
                    duration: const Duration(milliseconds: 300)
                  ),
                
                ],
              ),
            );
          }),
          
          space(12),

        ],
      ),
    );
  }

}