import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/single_content_model.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/single_course_widget/course_video_player.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/database/app_database.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class OfflineSingleContentPage extends StatefulWidget {
  static const String pageName = '/offline-single-content';
  const OfflineSingleContentPage({super.key});

  @override
  State<OfflineSingleContentPage> createState() => _OfflineSingleContentPageState();
}

class _OfflineSingleContentPageState extends State<OfflineSingleContentPage> {
  
  int? courseId;
  ContentItem? content;
  SingleContentModel? singleContent;
  
  List<String> videoFormats = ['mp4', 'mkv', 'mov', 'wmv', 'avi', 'webm', 'video'];
  String videoPath='';


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      courseId = (ModalRoute.of(context)!.settings.arguments as List)[0];
      content = (ModalRoute.of(context)!.settings.arguments as List)[1];

      if(content != null){
        singleContent = await AppDataBase.getListOfSingleContentDataAtDB(courseId!, content!.id!);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.courseDetails),

        body: Stack(
          children: [

            // body
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20,width: getSize().width),
          
                    Text(
                      content?.title ?? '',
                      style: style16Bold(),
                    ),

                    space(20),

                    
                    if( (singleContent?.storage == 'upload' || singleContent?.storage == 'external_link' || singleContent?.storage == 's3') && videoFormats.contains(singleContent?.fileType?.toLowerCase()) )...{
                      space(20),
          
                      CourseVideoPlayer(
                        singleContent?.file ?? '', '', Constants.singleCourseRouteObserver,
                        isLoadNetwork: false,
                        localFileName: singleContent?.file?.split('/').last ?? '${singleContent?.title}.${singleContent?.fileType}',
                      ),
                    },


                    space(30),

                    // info   
                    Container(
                      padding: padding(),
                      width: getSize().width,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        
                        runSpacing: 21,
                        children: [
                    
                          SingleCourseWidget.courseStatus(
                            appText.type, 
                            content?.type == 'file'
                              ? singleContent?.fileType?.toString().toUpperCase() ?? ''
                              : content?.type == 'session' 
                                ? singleContent?.sessionApi?.toString() ?? ''
                                : appText.text_lesson, 
                            AppAssets.documentSvg,
                            width: getSize().width * .38
                          ),
                    
                          if(singleContent?.date != null)...{
                            SingleCourseWidget.courseStatus(
                              appText.startDate, 
                              timeStampToDate((singleContent?.date ?? 0) * 1000).toString(), 
                              AppAssets.calendarSvg,
                              width: getSize().width * .38
                            ),
                          },
                          
                    
                          if(singleContent?.volume != null)...{
                            SingleCourseWidget.courseStatus(
                              appText.volume, 
                              singleContent?.volume ?? '', 
                              AppAssets.paperDownloadSvg,
                              width: getSize().width * .38
                            ),
                          },
                          
                          if(singleContent?.createdAt != null)...{
                            SingleCourseWidget.courseStatus(
                              appText.publishDate, 
                              timeStampToDate((singleContent?.createdAt ?? 0) * 1000).toString(), 
                              AppAssets.calendarSvg,
                              width: getSize().width * .38
                            ),
                          },
                          
                          if(singleContent?.duration != null)...{
                            SingleCourseWidget.courseStatus(
                              appText.duration, 
                              '${(singleContent?.duration ?? 0)} ${appText.min}', 
                              AppAssets.timeSvg,
                              width: getSize().width * .38
                            ),
                          },
                          
                          SingleCourseWidget.courseStatus(
                            appText.downloadable, 
                            content?.downloadable == 1 ? appText.yes : appText.no, 
                            AppAssets.paperDownloadSvg,
                            width: getSize().width * .38
                          ),
                          
                          
                        ],  
                      ),
                    ),

                    if(content?.type == 'text_lesson')...{
                      
                      space(20),
          
                      HtmlWidget(
                        singleContent?.content ?? '',
                        textStyle: style14Regular().copyWith(color: greyA5),
                      ),
                    }else...{
                      
                      space(20),
                      
                      Text(
                        singleContent?.description ?? '',
                        style: style14Regular().copyWith(color: greyA5),
                      ),
                    },
          

                  ],
                ),
              )
            ),


            // back button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              bottom: 0,
              child: Container(
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
                    backRoute();
                  },
                  width: getSize().width, 
                  height: 52, 
                  text: appText.back, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),
              )
            ),


          ],
        ),
      )
    );
  }
}