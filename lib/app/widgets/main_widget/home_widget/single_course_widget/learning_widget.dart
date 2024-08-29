import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:path_provider/path_provider.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/forum_answer_model.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/app/models/notice_model.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/app/pages/main_page/home_page/certificates_page/certificates_page.dart';
import 'package:webinar/app/pages/main_page/home_page/assignments_page/assignments_page.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/forum_page/search_forum_page.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/single_content_page/single_content_page.dart';
import 'package:webinar/app/pages/main_page/home_page/quizzes_page/quiz_page.dart';
import 'package:webinar/app/pages/main_page/home_page/quizzes_page/quizzes_page.dart';
import 'package:webinar/app/services/user_service/forum_service.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/common.dart';
import '../../../../../common/components.dart';
import '../../../../../common/utils/app_text.dart';
import '../../../../../common/utils/date_formater.dart';
import '../../../../../config/assets.dart';
import '../../../../../config/colors.dart';
import '../../../../models/can_model.dart';
import '../../../../pages/main_page/categories_page/categories_page.dart';

class LearningWidget{

  static Widget contentPage(List<ContentModel> contents,int courseId,Function setState, Function getNewData){
    
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
                          contents[index].title ?? '', 
                          '${contents[index].items?.length ?? 0} ${appText.lessons
                          }', (){
                            contents[index].isOpen = !(contents[index].isOpen);
                            setState();
                          },
                          transparentColor: true,
                          isFixWidth: true,
                          iconColor: Colors.white
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


                                  for (var i = 0; i < index; i++) {
                                    if(contents[i].checkAllContentsPass == 1){

                                      for (var j = 0; j < (contents[i].items?.length ?? 0); j++) {
                                        if(contents[i].items?[j].authHasRead == false){
                                          closeSnackBar();
                                          showSnackBar(ErrorEnum.error, appText.accessDenied, desc: appText.accessDeniedDesc);
                                          return;
                                        }  
                                      }

                                    }
                                  }

                                  if(contents[index].checkAllContentsPass == 1){}

                                  if(contents[index].items![i].type == 'assignment'){
                                    nextRoute(AssignmentsPage.pageName);
                                  }else if(contents[index].items![i].type == 'quiz'){
                                    nextRoute(QuizzesPage.pageName);
                                  }else{

                                    int previousIndex = i - 1;
                                    String? previousLink;

                                    if(previousIndex >= 0){
                                      previousLink = contents[index].items![previousIndex].link;
                                    }

                                    await nextRoute(
                                      SingleContentPage.pageName, 
                                      arguments: [
                                        contents[index].items![i], 
                                        courseId, 
                                        previousLink 
                                      ]
                                    );

                                    getNewData();

                                  }
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

  static Widget quizezPage(SingleCourseModel? courseData){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(),
      child: Column(
        children: [

          space(8),

          ...List.generate(courseData!.quizzes.length, (i) {
            return horizontalChapterItem(
              green9D, 
              AppAssets.shieldSvg, 
              courseData.quizzes[i].title ?? '', 
              '${courseData.quizzes[i].questionCount} ${appText.questions} | ${courseData.quizzes[i].time} ${appText.min}', 
              (){
                nextRoute(QuizPage.pageName,arguments: [courseData.quizzes[i].id]);
              },
              isFixWidth: true
            );
          })
          
        ],
      ),
    );
  }

  static Widget certificates(SingleCourseModel? courseData){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(),

      child: Column(
        children: [

          space(8),

          ...List.generate(courseData!.certificates.length, (i) {
            return horizontalChapterItem(
              orange50, 
              AppAssets.certificates2Svg, 
              courseData.certificates[i].title ?? '', 
              timeStampToDate((courseData.certificates[i].createdAt ?? 0) * 1000 ), 
              (){
                nextRoute(CertificatesPage.pageName);
              },
              isFixWidth: true
            );
          }),
        ],
      ),
    ); 
  }

  static Widget notices(List<NoticeModel> noticesData){

    Color checkColor(String type){
      
      switch (type) {
        case 'danger':
          return red49;
          
        case 'warning':
          return yellow29;
          
        case 'info':
          return blueFE;
          
        case 'success':
          return green77();
        
        case 'neutral':
          return greyE7;
          
        default:
          return green77();
      }
      
    }

    String checkIcon(String icon){
      
      switch (icon) {
        case 'danger':
          return AppAssets.dangerSvg;
          
        case 'warning':
          return AppAssets.infoCircleSvg;
          
        case 'info':
          return AppAssets.infoSquareSvg;
          
        case 'success':
          return AppAssets.checkCircleSvg;
        
        case 'neutral':
          return AppAssets.moreCircleSvg;
          
        default:
          return AppAssets.dangerSvg;
      }
      
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding(),

      child: Column(
        children: [

          space(8),

          ...List.generate(noticesData.length, (i) {
            return horizontalNoticesItem(
              checkColor(noticesData[i].color!), 
              checkIcon(noticesData[i].color!), 
              noticesData[i].title ?? '', 
              noticesData[i].creator?.fullName ?? '', 
              timeStampToDate((noticesData[i].createdAt ?? 0) * 1000 ), 
              (){
                noticeDetails(noticesData[i]);
              },
            
            );
          }),
        ],
      ),
    ); 
  }

  static Widget forum(ForumModel? forumData,Function(int index) changeState,Function onRefreshData){
    return RefreshIndicator(
      onRefresh: () async{
        await onRefreshData();
      },
      color: green77(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
    
        child: forumData?.forums?.isEmpty ?? true
      ? Center(
          child: Padding(
            padding: EdgeInsets.only(top: getSize().height * .2),
            child: emptyState(AppAssets.commentsEmptyStateSvg, appText.noQuestion, appText.noQuestionDesc),
          )
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            space(8),
    
            // info box
            SizedBox(
              width: getSize().width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: padding(),
    
                child: Row(
                  children: [
                    
                    dashboardInfoBox(orange50, AppAssets.questionmarkSvg, forumData?.questionsCount?.toString() ?? '-', appText.questions, (){}, height: 145),
    
                    space(0,width: 16),
    
                    dashboardInfoBox(green50, AppAssets.tickSquareSvg, forumData?.resolvedCount?.toString() ?? '-', appText.resolved, (){}, height: 145),
    
                    space(0,width: 16),
                    
                    dashboardInfoBox(blueFE, AppAssets.moreCircleSvg, forumData?.openQuestionsCount?.toString() ?? '-', appText.openQuestions, (){}, height: 145),
                    
                    space(0,width: 16),
                    
                    dashboardInfoBox(green50, AppAssets.chatMoreSvg, forumData?.commentsCount?.toString() ?? '-', appText.answers, (){}, height: 145),
                    
                    space(0,width: 16),
                    
                    dashboardInfoBox(blue64(), AppAssets.provideresSvg, forumData?.activeUsersCount?.toString() ?? '-', appText.activeUsers, (){}, height: 145),
                    
                  ],
                ),
              ),
            ),
    
            space(20),
    
    
            // questions
            SizedBox(
              width: getSize().width,
              child: Padding(
                padding: padding(),
                child: Column(
                  children: [
              
                    ...List.generate(forumData?.forums?.length ?? 0, (index) {
                      return forumQuestionItem(forumData!.forums![index], (){
                        changeState(index);
                      });
                    }),
    
    
                    space(120),
              
                  ],
                ),
              )
            )
    
    
    
          ],
        ),
      ),
    ); 
  }




  static noticeDetails(NoticeModel notice){
    baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            space(24),


            Text(
              notice.title ?? '',
              style: style16Bold(),
            ),

            space(18),

            // user info
            Container(
              width: getSize().width,
              padding: padding(horizontal: 8,vertical: 8),

              decoration: BoxDecoration(
                border: Border.all(
                  color: greyE7,
                ),
                borderRadius: borderRadius(),
              ),

              child: Row(
                children: [

                  ClipRRect(
                    borderRadius: borderRadius(radius: 60),
                    child: fadeInImage(
                      notice.creator?.avatar ?? '', 
                      40, 
                      40
                    ),
                  ),

                  space(0, width: 5),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Text(
                          appText.postedBy,
                          style: style10Regular().copyWith(color: greyB2),  
                        ),
                  
                        space(3),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text(
                              notice.creator?.fullName ?? '',
                              style: style14Bold(),  
                            ),
                            
                            Text(
                              timeStampToDate((notice.createdAt ?? 0) * 1000),
                              style: style10Regular().copyWith(color: greyB2),  
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  )



                ],
              ),
            ),

            space(16),

            HtmlWidget(
              notice.message ?? '',
              textStyle: style14Regular().copyWith(color: greyA5),
            ),

            space(16),

            button(
              onTap: backRoute, 
              width: getSize().width, 
              height: 52, 
              text: appText.close, 
              bgColor: green77(), 
              textColor: Colors.white
            ),
            
            space(26),

          ],
        ),
      )
    );
  }


  static forumSearchSheet(int courseId){

    TextEditingController searchController = TextEditingController();
    FocusNode searchNode = FocusNode();

    baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                space(20),
          
                Text(
                  appText.searchInCourseForum,
                  style: style16Bold(),
                ),

                space(16),

                input(searchController, searchNode, appText.search, isBorder: true,iconPathLeft: AppAssets.searchSvg),

                space(24),

                button(
                  onTap: (){

                    if(searchController.text.trim().isNotEmpty){
                      backRoute();
                      nextRoute(SearchForumPage.pageName, arguments: [searchController.text.trim(), courseId]);
                    }

                  },
                  width: getSize().width, 
                  height: 52, 
                  text: appText.search, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),

                space(28),

          
              ],
            ),
          );
        },
      )
    );
  }

  static Future forumOptionSheet(Can can,bool isPin,Function onTapPin,Function onTapMarkAsResolved,Function onTapEdit) async {

    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                space(20),
          
                Text(
                  appText.options,
                  style: style16Bold(),
                ),

                if(can.pin ?? false)...{
                  space(28),

                  GestureDetector(
                    onTap: (){
                      onTapPin();
                      backRoute();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        SvgPicture.asset(AppAssets.bookmarkLineSvg, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),

                        space(0,width: 8),

                        Text(
                          isPin ? appText.unpin : appText.pin,
                          style: style16Regular(),
                        )

                      ],
                    ),
                  ),
                },

                if(can.resolve ?? false)...{
                  space(28),

                  GestureDetector(
                    onTap: (){
                      backRoute();
                      
                      onTapMarkAsResolved();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        SvgPicture.asset(AppAssets.tickLineSvg, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),

                        space(0,width: 8),

                        Text(
                          appText.markAsResolved,
                          style: style16Regular(),
                        )

                      ],
                    ),
                  ),
                },

                if(can.update  ?? false)...{
                  space(28),

                  GestureDetector(
                    onTap: (){
                      backRoute();
                      
                      onTapEdit();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        SvgPicture.asset(AppAssets.editSvg, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),

                        space(0,width: 8),

                        Text(
                          appText.edit,
                          style: style16Regular(),
                        )

                      ],
                    ),
                  ),
                },

                space(50),

          
              ],
            ),
          );
        },
      )
    );
  }

  
  static Future forumNewQuestionSheet(int courseId) async {

    TextEditingController titleController = TextEditingController();
    FocusNode titleNode = FocusNode();

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();

    // ignore: unused_local_variable
    File? attachment;
    bool isLoading = false;

    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: StatefulBuilder(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),
          
                    Text(
                      appText.newQuestion,
                      style: style16Bold(),
                    ),

                    space(16),

                    input(titleController, titleNode, appText.title, isBorder: true,iconPathLeft: AppAssets.profileSvg),

                    space(12),

                    descriptionInput(descController, descNode, appText.description, isBorder: true,),

                    space(16),

                    Row(
                      children: [

                        button(
                          onTap: () async {

                            final imagePicker.ImagePicker picker = imagePicker.ImagePicker();
                            final imagePicker.XFile? image = await picker.pickImage(source: imagePicker.ImageSource.gallery);


                            if(image != null){
                              Directory appDocDir = await getApplicationDocumentsDirectory();
                              String address = '${appDocDir.path}/${DateTime.now().millisecond}.jpg';

                              var result = await FlutterImageCompress.compressAndGetFile(
                                File(image.path).path, 
                                address,
                                quality: 75,
                                minWidth: 700,
                              );

                              attachment = File(result!.path);
                             
                            }

                            
                          }, 
                          width: 52,
                          height: 52,
                          text: '', 
                          bgColor: Colors.white, 
                          textColor: green77(),
                          iconPath: AppAssets.attachmentSvg,
                          borderColor: green77()
                        ),
                        
                        space(0,width: 16),

                        Expanded(
                          child: button(
                            onTap: () async {

                              if(titleController.text.trim().isNotEmpty && descController.text.trim().isNotEmpty){
                                state((){
                                  isLoading = true;
                                });
                                
                                bool res = await ForumService.newQuestion(
                                  courseId, 
                                  titleController.text.trim(), 
                                  descController.text.trim(), 
                                  attachment
                                );

                                if(res){
                                  backRoute(arguments: true);
                                }

                                state((){
                                  isLoading = false;
                                });
                              }

                            }, 
                            width: getSize().width,
                            height: 52,
                            text: appText.send, 
                            bgColor: green77(), 
                            textColor: Colors.white,
                            isLoading: isLoading
                          )
                        ),

                      ],
                    ),

                    space(28),

          
                  ],
                );
              }
            ),
          );
        },
      )
    );
  }
  
  static Future forumReplaySheet(Forums? question,{bool isEdit=false, ForumAnswerModel? answer}) async {

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();


    bool isLoading = false;

    if(isEdit){
      descController.text = answer?.description ?? '';
    }


    return await baseBottomSheet(
      child: StatefulBuilder(
        builder: (context,state) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                space(20),
          
                Text(
                  appText.reply,
                  style: style16Bold(),
                ),

                space(16),

                descriptionInput(descController, descNode, appText.description, isBorder: true,),

                space(16),

                Center(
                  child: button(
                    onTap: () async {
                
                      if(isEdit){
                
                        isLoading = true;
                        state((){});
                        
                        bool res = await ForumService.updateAnswer(answer!.id!, descController.text.trim());
                
                        isLoading = false;
                        state((){});
                        
                        if(res){
                          backRoute(arguments: true);
                        }
                
                      }else{
                
                        isLoading = true;
                        state((){});
                
                        bool res = await ForumService.setAnswer(question!.id!, descController.text.trim());
                        
                        isLoading = false;
                        state((){});
                        
                        if(res){
                          backRoute(arguments: true);
                        }
                      }
                    }, 
                    width: getSize().width,
                    height: 52,
                    text: isEdit ? appText.edit : appText.reply, 
                    bgColor: green77(), 
                    textColor: Colors.white,
                    isLoading: isLoading
                  ),
                ),

                space(28),

          
              ],
            ),
          );
        },
      )
    );
  }

  
}