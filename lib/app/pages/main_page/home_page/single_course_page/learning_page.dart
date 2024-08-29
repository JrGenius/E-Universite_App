
import 'package:flutter/material.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/app/services/user_service/forum_service.dart';
import 'package:webinar/app/widgets/main_widget/home_widget/single_course_widget/learning_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/assets.dart';

import '../../../../../common/utils/app_text.dart';
import '../../../../../config/colors.dart';
import '../../../../models/notice_model.dart';

class LearningPage extends StatefulWidget {
  static const String pageName = '/learning-page';
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with TickerProviderStateMixin{

  SingleCourseModel? courseData;
  late TabController tabController;

  int currentTab = 0;

  List<NoticeModel> noticesData = [];

  ForumModel? forumData;
  bool isShowForumButton = false;
  
   
  List<ContentModel> contents = [];
  bool isContentLoading = true;

  List<Tab> tabList = [];


  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      courseData = ModalRoute.of(context)!.settings.arguments as SingleCourseModel;

      
    

      Future.wait([getContentData(), getNoticesData(), getForumData()]).then((value) {
        isContentLoading = false;

        tabList = [ 

          Tab(
            text: appText.content,
            height: 32,
          ),
          
          if(courseData?.quizzes.isNotEmpty ?? true)...{
            Tab(
              text: appText.quizzes,
              height: 32,
            ),
          },
          
          if(courseData?.certificates.isNotEmpty ?? true)...{
            Tab(
              text: appText.certificates,
              height: 32,
            ), 
          },
          
          if(noticesData.isNotEmpty)...{
            Tab(
              text: appText.notices,
              height: 32,
            ), 
          },

          if(courseData?.forum == 1)...{
            Tab(
              text: appText.forum,
              height: 32,
            ), 
          }
          

        ];
        

        tabController = TabController(length: tabList.length, vsync: this);
        setState(() {});
      });


    });

  }

  onChangeTab(int i){
    setState(() {
      currentTab = i;
    });
  }


  Future getContentData({bool canOffLoading=false}) async {

    setState(() {
      isContentLoading = true;
    });

    contents = await CourseService.getContent(courseData!.id!);
    
    if(canOffLoading){
      setState(() {
        isContentLoading = false;
      });
    }
  }


  Future getNoticesData() async {

    noticesData = await CourseService.getNotices(courseData!.id!);
    
    setState(() {});
  }

  Future getForumData() async {
    forumData = await ForumService.getForumData(courseData!.id!,'');
    
    setState(() {});

  }

  tabListener(){

    tabController.addListener(() {
      if(tabController.index == tabController.length - 1){
        setState(() {
          isShowForumButton = true;
        });

      }else{

        if(isShowForumButton){
          setState(() {
            isShowForumButton = false;
          });
        }
      }
    });
    
  }


  @override
  Widget build(BuildContext context) {


    return directionality(
      child: Scaffold(

        appBar: appbar(
          title: courseData?.title ?? '',
        ),
        
        body: courseData == null
      ? const SizedBox()
      : Stack(
          children: [
            
            Positioned.fill(
              child: isContentLoading
            ? loading()
            : Column(
                children: [
          
                  // tab bar
                  SizedBox(
                    width: getSize().width,
                    child: tabBar(
                      (i){}, 
                      tabController, 
                      tabList
                    ),
                  ),
          
                  space(8),
          
                  if(courseData != null)...{
                    
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          
                          isContentLoading
                        ? Center(child: loading())
                        : LearningWidget.contentPage(
                            contents, 
                            courseData!.id!,
                            (){
                              setState(() {});
                            },
                            (){
                              getContentData(canOffLoading: true);
                            }
                          ),
          
                          if(courseData?.quizzes.isNotEmpty ?? true)...{
                            LearningWidget.quizezPage(courseData),
                          },
          
                          if(courseData?.certificates.isNotEmpty ?? true)...{
                            LearningWidget.certificates(courseData),
                          },
                          
                          if(noticesData.isNotEmpty)...{
                            LearningWidget.notices(noticesData),
                          },

                          if(courseData?.forum == 1)...{

                            LearningWidget.forum(
                              forumData,
                              (i){
                                setState(() {});

                                ForumService.pin(forumData!.forums![i].id!).then((value) {
                                  getForumData();
                                });
                              },
                              () async {
                                await getForumData();
                              }
                            ),
                          }
          
                        ],
                      )
                    )
                  }
          
          
                ],
              ),
            ),

            // forum button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isShowForumButton ? 0 : -150,
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

                child: Row(
                  children: [
                    
                    Expanded(
                      child:  button(
                        onTap: () async {
                          bool? res = await LearningWidget.forumNewQuestionSheet(courseData!.id!);

                          if(res != null && res){
                            getForumData();
                          }
                        },
                        width: getSize().width, 
                        height: 52, 
                        text: appText.leaveAComment, 
                        bgColor: green77(), 
                        textColor: Colors.white
                      ),
                    ),


                    if(forumData?.forums?.isNotEmpty ?? false)...{

                      space(0,width: 14),

                      button(
                        onTap: (){
                          LearningWidget.forumSearchSheet(courseData!.id!);
                        }, 
                        width: 52, 
                        height: 52, 
                        text: '', 
                        bgColor: greyF8, 
                        textColor: Colors.white,
                        iconPath: AppAssets.search2Svg
                      )
                    }

                  ],
                )
              )
            ),

          ],
        ),
      )
    );
  }


  

}