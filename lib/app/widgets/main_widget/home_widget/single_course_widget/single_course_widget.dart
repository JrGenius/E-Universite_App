import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webinar/app/models/content_model.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/app/pages/main_page/home_page/certificates_page/certificates_page.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/single_content_page/single_content_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/app/services/user_service/cart_service.dart';
import 'package:webinar/app/services/user_service/personal_note_service.dart';
import 'package:webinar/app/services/user_service/rewards_service.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/data/api_public_data.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/colors.dart';
import '../../../../../common/components.dart';
import '../../../../pages/main_page/home_page/assignments_page/assignments_page.dart';
import '../../../../pages/main_page/home_page/quizzes_page/quiz_page.dart';
import '../../../../pages/main_page/home_page/quizzes_page/quizzes_page.dart';
import '../../blog_widget/blog_widget.dart';

class SingleCourseWidget{


  static Widget informationPage(SingleCourseModel courseData, bool viewMore, Function onTapViewMore,Function changeState,{List<CourseModel> bundleCourses = const []}){
        
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // access
          SingleChildScrollView(
            padding: padding(),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                
                if(courseData.type == 'bundle')...{
                  courseOption(blueA4, AppAssets.playCircleSvg, bundleCourses.length.toString(), appText.courses),
                },
                
                if(courseData.certificates.isNotEmpty)...{
                  courseOption(orange50, AppAssets.certificateSvg, appText.certificate, appText.included),
                },
                
                if(courseData.quizzes.isNotEmpty)...{
                  courseOption(green9D, AppAssets.quizSvg, appText.quiz, appText.included),
                },
                
                if(courseData.support ?? false)...{
                  courseOption(blueFE, AppAssets.supportedSvg, appText.supported, appText.class_),
                },
                
                if(courseData.isDownloadable ?? false)...{
                  courseOption(green50, AppAssets.downloadableSvg, appText.downloadable, appText.content),
                },
              ],
            ),
          ),

          space(15),

          Container(
            padding: padding(),
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
                courseData.description ?? ''
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
                    onTap: onTapViewMore, 
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
                  courseData.salesCountNumber?.toString() ?? courseData.studentsCount?.toString() ?? '0', 
                  AppAssets.profileSvg,
                  width: (getSize().width * .5) - 42,
                ),
          
                if(courseData.type == 'course')...{
                  SingleCourseWidget.courseStatus(
                    appText.chapters, 
                    courseData.filesCount?.toString() ?? '', 
                    AppAssets.moreSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },

                if(courseData.createdAt != null)...{
                  SingleCourseWidget.courseStatus(
                    appText.publishDate, 
                    timeStampToDate((courseData.createdAt ?? 0) * 1000).toString(), 
                    AppAssets.calendarSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },
                
                SingleCourseWidget.courseStatus(
                  appText.duration, 
                  "${durationToString(courseData.duration ?? 0)} ${appText.hours}", 
                  AppAssets.timeCircleSvg,
                  width: (getSize().width * .5) - 42,
                ),


                if(courseData.capacity != null)...{
                  SingleCourseWidget.courseStatus(
                    appText.capacity, 
                    courseData.capacity?.toString() ?? '', 
                    AppAssets.provideresSvg,
                    width: (getSize().width * .5) - 42,
                  ),
                },
          
                
                
                
                
                // SingleCourseWidget.courseStatus(
                //   appText.status, 
                //   courseData.status ?? '', 
                //   AppAssets.moreSvg,
                //   width: (getSize().width * .5) - 42,
                // ),
          
              ],  
            ),
          ),
          
          
          space(28),

          // faq
          ...List.generate(courseData.faqs?.length ?? 0, (index) {
            return Padding(
              padding: padding(),
              child: faqDropDown(
                courseData.faqs?[index].title ?? '', 
                courseData.faqs?[index].answer ?? '', 
                courseData.faqs?[index].isOpen ?? false, 
                AppAssets.questionSvg,
                (){ 
                  courseData.faqs?[index].isOpen = !(courseData.faqs?[index].isOpen ?? false);
                  changeState();
                }
              ),
            );
          }),

          if(courseData.prerequisites.isNotEmpty)...{

            space(30),

            Padding(
              padding: padding(),
              child: Text(
                appText.prerequisties,
                style: style16Bold(),
              ),
            ),

            space(16),

            SizedBox(
              width: getSize().width,
              height: 215,
              child: PageView.builder(
                itemCount: courseData.prerequisites.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return courseSliderItem(
                    courseData.prerequisites[index].webinar!,
                  );
                },
              ),
            ),

          },
          
          space(200),

    
        ],
      ),
    );
  }

  static Widget contentPage(SingleCourseModel courseData,List<ContentModel> contents,{List<CourseModel> bundleCourses = const []}){
    
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
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [

          if(courseData.type == 'bundle')...{

            ...List.generate(bundleCourses.length, (index) {
              return Padding(
                padding: padding(),
                child: courseItemVertically(
                  bundleCourses[index],
                ),
              );
            })

          }else...{

            // content
            ...List.generate(contents.length, (index) {
              return Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space(0,width: getSize().width),

                  Padding(
                    padding: padding(),
                    child: Text(
                      contents[index].title ?? '',
                      style: style16Bold(),
                    ),
                  ),

                  space(14),

                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: padding(),
                    child: Row(
                      children: List.generate(contents[index].items?.length ?? 0, (i) {
                        return horizontalChapterItem(
                          colorType(contents[index].items![i]),
                          iconType(contents[index].items![i]),
                          contents[index].items?[i].title ?? '', 
                          subTitleType(contents[index].items![i]),
                          (){
                            
                            if(contents[index].items?[i].can?.view ?? false){

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

                                nextRoute(
                                  SingleContentPage.pageName, 
                                  arguments: [
                                    contents[index].items![i], 
                                    courseData.id,
                                    previousLink
                                  ]
                                );

                              }

                            }else{
                              closeSnackBar();
                              showSnackBar(ErrorEnum.alert, appText.notAccessContent);
                            }
                          },
                          height: sizeType(contents[index].items![i]).toDouble(),
                          
                        );
                      }),
                    ),
                  ),

                  space(16),
                  
                ]
              );
            }),


           

            // quiz 
            if(courseData.quizzes.isNotEmpty) ... {
              
              SizedBox(
                width: getSize().width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: padding(),
                      child: Text(
                        appText.quiz,
                        style: style16Bold(),
                      ),
                    ),

                    space(14),

                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: padding(),
                      child: Row(
                        children: List.generate(courseData.quizzes.length, (i) {
                          return horizontalChapterItem(
                            green9D, 
                            AppAssets.shieldSvg, 
                            courseData.quizzes[i].title ?? '', 
                            '${courseData.quizzes[i].questionCount} ${appText.questions} | ${courseData.quizzes[i].time} ${appText.min}', 
                            (){
                              nextRoute(QuizPage.pageName,arguments: [courseData.quizzes[i].id]);
                            }
                          );
                        }),
                      ),
                    ),

                  ],
                ),
              ),
            
            },

            // Certificates 
            if(courseData.certificates.isNotEmpty) ... {
              space(16),

              SizedBox(
                width: getSize().width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: padding(),
                      child: Text(
                        appText.certificates,
                        style: style16Bold(),
                      ),
                    ),

                    space(14),

                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: padding(),
                      child: Row(
                        children: List.generate(courseData.certificates.length, (i) {
                          return horizontalChapterItem(
                            orange50, 
                            AppAssets.certificates2Svg, 
                            courseData.certificates[i].title ?? '', 
                            timeStampToDate((courseData.certificates[i].createdAt ?? 0) * 1000 ), 
                            (){
                              nextRoute(CertificatesPage.pageName);
                            }
                          );
                        }),
                      ),
                    ),

                  ],
                ),
              ),
            }


          }

        ],
      ),
    );
  }

  static Widget reviewsPage(SingleCourseModel courseData){

    Widget progressBar(String title, double rate){
      return Row(  
        children: [

          Text(
            title,
            style: style12Regular().copyWith(color: greyA5),
          ),

          space(0, width: 12),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {

                return Container(
                  width: constraints.maxWidth,
                  height: 4,
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    width: constraints.maxWidth * (rate / 5),
                    height: 4,
                    decoration: BoxDecoration(
                      color: yellow29,
                      borderRadius: borderRadius(),
                    ),
                  ),
                );
              },
            )
          )

        ],
      );
    }


    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: padding(),
      child: courseData.reviews?.isEmpty ?? true
    ? emptyState(AppAssets.reviewEmptyStateSvg, appText.noReviews, appText.noReviewsDesc)
    : Column(
        children: [
          
          // rate box
          Container(
            width: getSize().width,
            padding: padding(horizontal: 16,vertical: 16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius(),
            ),

            child: Column(
              children: [

                Text(
                  courseData.rate?.toString() ?? '0',
                  style: style24Bold().copyWith(fontSize: 28),
                ),

                ratingBar(courseData.rate?.toString() ?? '0', itemSize: 16),

                space(8),

                Container(
                  padding: padding(horizontal: 6,vertical: 4),
                  decoration: BoxDecoration(
                    color: greyE7,
                    borderRadius: borderRadius(radius: 20),
                  ),

                  child: Text(
                    '${courseData.reviewsCount ?? 0} ${appText.reviews}',
                    style: style10Regular().copyWith(color: greyB2,height: 1),
                  ),
                ),

                space(20),

                // Content Quality
                progressBar(appText.contentQuality, (courseData.rateType?.contentQuality ?? 0)),

                space(15),

                // Content Quality
                progressBar(appText.instructorSkills, (courseData.rateType?.instructorSkills ?? 0)),
                
                space(15),

                // Purchase Worth
                progressBar(appText.purchaseWorth, (courseData.rateType?.purchaseWorth ?? 0)),
                
                space(15),

                // Support Quality
                progressBar(appText.supportQuality, (courseData.rateType?.supportQuality ?? 0)),
                
                space(15),

              ],
            ),
          ),

          space(16),
          
          ...List.generate(courseData.reviews?.length ?? 0, (index) {
            return reviewUi(courseData.reviews![index], (){

            });
          }),
          
          
          
          space(120),

        ],
      ),
    );
  }

  static Widget commentsPage(SingleCourseModel courseData){
    
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: padding(),

      child: courseData.comments.isEmpty
    ? emptyState(AppAssets.commentsEmptyStateSvg, appText.noComments, appText.noCommentsCourseDesc)
    : Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ...List.generate(courseData.comments.length, (index) {
            return commentUi(courseData.comments[index], (){
              BlogWidget.showOptionDialog(courseData.id!, courseData.comments[index].id, true, itemName: 'webinar');              
            });
          }),

          space(120),
        ],
      ),
    );
  }



  static Widget reviewUi(ReviewModel review,Function onTapOption){
    return Container(
      width: getSize().width,
      padding: padding(horizontal: 16,vertical: 16),
      margin: const EdgeInsets.only(bottom: 16),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
        // border: Border.all()
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // user info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              userProfile(review.user!,showRate: true, customRate: review.rate),

              // GestureDetector(
              //   onTap: (){
              //     onTapOption();  
              //   },
              //   behavior: HitTestBehavior.opaque,
              //   child: SizedBox(
              //     width: 45,
              //     height: 45,
              //     child: Icon(Icons.more_horiz,size: 30,color: greyA5,),
              //   ),
              // )

            ],
          ),

          space(16),

          Text(
            review.description ?? '',
            style: style14Regular().copyWith(color: greyA5,height: 1.5),
          ),

          space(16),
          
          Text(
            timeStampToDate((review.createdAt ?? 0) * 1000),
            style: style14Regular().copyWith(color: greyA5,height: 1.5),
          ),


        ],
      ),
    );
              
  }

  static Widget courseOption(Color color,String icon,String title,String subTitle){
    return Container(
      padding: padding(horizontal: 12, vertical: 12),
      margin: const EdgeInsetsDirectional.only(end: 15),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(radius: 15)
      ),
      child: Row(
        children: [
  
          Container(
            width: 46,
            height: 46,
  
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius(radius: 8),
            ),
            alignment: Alignment.center,
  
            child: SvgPicture.asset(icon),
          ),
  
          space(0,width: 16),
  
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                Text(
                  title,
                  style: style14Bold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              
                space(4),
                
                Text(
                  subTitle,
                  style: style12Regular().copyWith(color: greyA5),
                ),
              
              ],
            ),
          ),
  
        ],
      ),
    
    );
  }

  static Widget courseStatus(String title,String desc,String iconPath, {double? width}){
    return SizedBox(
      width: width ?? getSize().width / 2,
      child: Row(
        children: [
          
          Container(
            width: 37,
            height: 37,
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: greyE7.withOpacity(.5),
              shape: BoxShape.circle
            ),

            child: SvgPicture.asset(iconPath,width: 17,colorFilter: ColorFilter.mode(greyB2, BlendMode.srcIn),),
          ),

          space(0, width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  title,
                  style: style12Regular().copyWith(color: greyA5),
                ),
          
                space(4),
                
                Text(
                  desc,
                  style: style14Bold()
                ),
          
              ],
            ),
          )

        ],
      ),
    );
  }



  static Widget privateContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SvgPicture.asset(AppAssets.privateModeSvg),

        space(20),

        Text(
          appText.privateContent,
          style: style20Bold(),
        ),

        space(10),

        Text(
          appText.privateContentDesc,
          style: style14Regular().copyWith(color: grey5E),
        ),

      ],
    );
  }

  static Widget pendingVerification(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SvgPicture.asset(AppAssets.pendingVerificationSvg),

        space(20),

        Text(
          appText.pendingVerification,
          style: style20Bold(),
        ),

        space(10),

        Text(
          appText.pendingVerificationDesc,
          style: style14Regular().copyWith(color: grey5E),
        ),

      ],
    );
  }



  static Future<bool?> pricingPlanDialog(SingleCourseModel courseData) async {
    
    String? selectedType;
    BuyTicketsModel? selectedTicket;
    
    bool isLoading = false;


    return await baseBottomSheet(
      child: StatefulBuilder(
        builder: (context, state) {
          return Padding(
            padding: padding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                space(20),
                
                Text(
                  appText.selectPricingPlan,
                  style: style16Bold(),
                ),
          
                space(20),

                if(courseData.tickets.isNotEmpty)...{
                  
                  // pricing plan
                  ...List.generate(courseData.tickets.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: (){
                          if(courseData.tickets[index].isValid ?? false){
                            selectedType = 'ticket';
                            selectedTicket = courseData.tickets[index];
                            state((){});
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: getSize().width,
                          padding: padding(horizontal: 9, vertical: 9),
                          
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: borderRadius(),
                            border: Border.all(
                              color: (selectedTicket?.id ?? -1) == courseData.tickets[index].id ? green77() : greyE7,
                              width: 1
                            )
                          ),
                              
                          child: Row(
                            children: [
                              
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: (courseData.tickets[index].isValid ?? false) ? green77() : greyCF,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                              
                                child: SvgPicture.asset(AppAssets.discountSvg),
                              ),

                              space(0, width: 9),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    // title
                                    Text(
                                      "${courseData.tickets[index].title} (${courseData.tickets[index].discount}% ${appText.off})",
                                      style: style14Bold(),
                                    ),
                                    
                                    // sub title and price
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                    
                                        Expanded(
                                          child: Text(
                                            courseData.tickets[index].subTitle ?? '',
                                            style: style12Regular().copyWith(color: greyB2),
                                          ),
                                        ),
                                        
                                    
                                        Text(
                                          CurrencyUtils.calculator(courseData.tickets[index].priceWithTicketDiscount ?? 0),
                                          style: style12Regular().copyWith(color: green77()),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  space(12),

                },

                if(courseData.points != null && courseData.points != 0)...{
                  space(4),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: (){
                        selectedTicket = null;
                        selectedType = 'point';
                        state((){});
                      },
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: getSize().width,
                        padding: padding(horizontal: 9, vertical: 9),
                        
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius(),
                          border: Border.all(
                            color: (selectedType ?? '') == 'point' ? yellow29 : greyE7,
                            width: 1
                          )
                        ),
                            
                        child: Row(
                          children: [
                            
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: (selectedType ?? '') == 'point' ? yellow29 : greyCF,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                            
                              child: SvgPicture.asset(AppAssets.starYellowSvg, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),width: 23,),
                            ),

                            space(0, width: 9),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  // title
                                  Text(
                                    appText.buyWithPoints,
                                    style: style14Bold(),
                                  ),

                                  space(4),
                                  
                                  // sub title and price
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                  
                                      Expanded(
                                        child: Text(
                                          '${appText.youHave} ${locator<UserProvider>().userPoint ?? 0} ${appText.rewardPoints}',
                                          style: style12Regular().copyWith(color: greyB2),
                                        ),
                                      ),
                                      
                                  
                                      Text(
                                        courseData.points?.toString() ?? '',
                                        style: style12Regular().copyWith(color: yellow29),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                },

                Center(
                  child: button(
                    onTap: () async {
                

                
                      if((selectedType ?? '') == 'point'){
                        state((){
                          isLoading = true;
                        });
              
                        bool res = await RewardsService.buyWithPoint(courseData.id!);
                        
                        state((){
                          isLoading = false;
                        });
              
                        if(res){
                          backRoute(arguments: true);
                        }
                        
                      }else if((selectedType ?? '') == 'ticket' && selectedTicket != null){
                        
                        state((){
                          isLoading = true;
                        });
              
                        bool res = await CartService.store(courseData.id!,selectedTicket!.id!);
                        
                        state((){
                          isLoading = false;
                        });
              
                        if(res){
                          backRoute(arguments: true);
                        }
                        
                      }else{
                        state((){
                          isLoading = true;
                        });
              
                        bool res = await CartService.add(
                          courseData.id!.toString(), 
                          courseData.type == 'bundle' ? 'bundle' : 'webinar', 
                          ''
                        );
                        
                        state((){
                          isLoading = false;
                        });
              
                        if(res){
                          backRoute(arguments: true);
                        }
                      }
                
                    }, 
                    width: getSize().width, 
                    height: 52, 
                    text: (selectedType ?? '') == 'point' ? appText.purchase : appText.addToCart, 
                    bgColor: green77(), 
                    textColor: Colors.white,
                    isLoading: isLoading
                  ),
                ),

                space(28),
          
              ],
            ),
          );
        }
      )
    );
  }

  static Future<bool?> showSetReviewDialog(SingleCourseModel courseData) async {
    
    int contentQuality = 4;
    int instructorSkills = 4;
    int purchaseWorth = 4;
    int supportQuality = 4;

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();

    bool isLoading = false;

    return await baseBottomSheet(
      child: Container(
        constraints: BoxConstraints(
          minHeight: getSize().height * .2,
          maxHeight: getSize().height * .9
        ),
        child: StatefulBuilder(
          builder: (_,state) {
            return Builder(
              builder: (context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  physics: const BouncingScrollPhysics(),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      space(25),
                      
                      Text(
                        appText.reviewTheCourse,
                        style: style20Bold(),
                      ),
                      
                      Text(
                        appText.reviewTheCourse,
                        style: style12Regular().copyWith(color: greyA5),
                      ),
                      
                              
                      space(28),
                              
                      // contentQuality
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          Text(
                            appText.contentQuality,
                            style: style14Regular().copyWith(color: greyA5),
                          ),
                              
                          ratingBar(contentQuality.toString(),itemSize: 25,onRatingUpdate: (p0) {
                            contentQuality = p0.toInt();
                            state((){});
                          }),
                        ],
                      ),
                      
                      space(18),
                              
                      // instrcutors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          Text(
                            appText.instrcutors,
                            style: style14Regular().copyWith(color: greyA5),
                          ),
                              
                          ratingBar(instructorSkills.toString(),itemSize: 25,onRatingUpdate: (p0) {
                            instructorSkills = p0.toInt();
                            state((){});
                          }),
                        ],
                      ),
                              
                      space(18),
                              
                      // purchaseWorth
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          Text(
                            appText.purchaseWorth,
                            style: style14Regular().copyWith(color: greyA5),
                          ),
                              
                          ratingBar(purchaseWorth.toString(),itemSize: 25,onRatingUpdate: (p0) {
                            purchaseWorth = p0.toInt();
                            state((){});
                          }),
                        ],
                      ),
                      
                      space(18),
                              
                      // supportQuality
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          Text(
                            appText.supportQuality,
                            style: style14Regular().copyWith(color: greyA5),
                          ),
                              
                          ratingBar(supportQuality.toString(),itemSize: 25,onRatingUpdate: (p0) {
                            supportQuality = p0.toInt();
                            state((){});
                          }),
                        ],
                      ),
                              
                      space(24),
                              
                      descriptionInput(descController, descNode, appText.description, isBorder: true),
                              
                      space(30),
                              
                      Center(
                        child: button(
                          onTap: () async {

                            if(descController.text.trim().isNotEmpty){

                              isLoading = true;
                              state((){});
                              
                              bool res = await UserService.storeReview(courseData.id!, contentQuality, instructorSkills, purchaseWorth, supportQuality, descController.text.trim());

                              isLoading = false;
                              state((){});

                              if(res){
                                backRoute(arguments: res);
                              }
                              
                            }
                          }, 
                          width: getSize().width, 
                          height: 52, 
                          text: appText.submit, 
                          bgColor: green77(), 
                          textColor: Colors.white,
                          isLoading: isLoading
                        ),
                      ),
                              
                      space(50),
                      
                    ],
                  ),
                );
              }
            );
          }
        ),
      )
    );
  }

  static showOptionsDialog(SingleCourseModel courseData, String token,{bool isBundle = false}){
    baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            space(25),
      
            Text(
              appText.classOptions,
              style: style20Bold(),
            ),
      

            // add to calender
            if(courseData.startDate != null) ...{
              space(14),
              
              GestureDetector(
                onTap: (){
                  backRoute();

                  try{
                                    
                    DateTime start = DateTime(
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).year,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).month,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).day,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).hour,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).minute,
                    );
                    DateTime end = DateTime(
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).year,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).month,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).day,
                      DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).hour,
                      (DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) * 1000, isUtc: true).minute + (courseData.duration ?? 0)),
                    );

                    final Event event = Event(
                      title: courseData.title ?? '',
                      description: appText.webinar,
                      startDate: start,
                      endDate: end,
                      iosParams: const IOSParams(),
                      androidParams: const AndroidParams(),
                    );

                    Add2Calendar.addEvent2Cal(event);

                  }catch(e){}
                  
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
            
                    SvgPicture.asset(AppAssets.calendarEmptySvg),
            
                    space(0,width: 8),
            
                    Text(
                      appText.addToCalendar,
                      style: style16Regular(),
                    ),
            
                  ],
                ),
              ),
            },

            space(28),

            if(token.isNotEmpty)...{
              // add to favorite
              GestureDetector(
                onTap: (){
                  courseData.isFavorite = !(courseData.isFavorite ?? false);
                  CourseService.addFavorite(courseData.id!, isBundle);
                  
                  backRoute();
                  
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
            
                    SvgPicture.asset(AppAssets.favoriteEmptySvg),
            
                    space(0,width: 8),
            
                    Text(
                      !(courseData.isFavorite ?? true)
                      ? appText.addToFavorites
                      : appText.removeFromFavorites,
                      style: style16Regular(),
                    ),
            
                  ],
                ),
              ),

              space(28),

            },

            // share
            GestureDetector(
              onTap: (){
                backRoute();

                try{
                  Share.share(courseData.link ?? '');
                }catch(e){}
                
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
          
                  SvgPicture.asset(AppAssets.shareSvg),
          
                  space(0,width: 8),
          
                  Text(
                    appText.share,
                    style: style16Regular(),
                  ),
          
                ],
              ),
            ),


            space(28),
            
            // report
            GestureDetector(
              onTap: (){
                backRoute();

                showReportDialog(courseData.id!);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
          
                  SvgPicture.asset(AppAssets.reportSvg),
          
                  space(0,width: 8),
          
                  Text(
                    appText.report,
                    style: style16Regular(),
                  ),
          
                ],
              ),
            ),


            space(50),
      
          ],
        ),
      )
    );
  }

  static showReportDialog(int courseId){
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();

    String reasonSelected = '';
    bool isOpen = false;
    
    
    return baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context,state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.messageToReviewer,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    dropDown(
                      appText.selectReportReason, reasonSelected, PublicData.reasonsData, 
                      (){
                        state((){
                          isOpen = !isOpen;
                        });
                      },
                      (newValue, index) {
                        state((){
                          reasonSelected = newValue;
                        });
                      }, 
                      isOpen
                    ),

                    space(8),

                    descriptionInput(messageController, messageNode, appText.submitCommentDesc,isBorder: true,),
              
                    space(20),

                    button(
                      onTap: (){
                        if(messageController.text.trim().isNotEmpty){
                          CourseService.reportCourse(
                            reasonSelected,
                            courseId,
                            messageController.text.trim()
                          );

                          backRoute();
                        }
                      }, 
                      width: getSize().width, 
                      height: 52, 
                      text: appText.report,
                      bgColor: green77(), 
                      textColor: Colors.white
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }


  static showAddNoteDialog(int courseId, int itemId,{String? text}) async {
    
    TextEditingController messageController = TextEditingController(text: text);
    FocusNode messageNode = FocusNode();

    bool isLoading=false;
    
    
    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context,state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.courseNote,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    descriptionInput(messageController, messageNode, appText.description, isBorder: true,),
              
                    space(20),

                    Center(
                      child: button(
                        onTap: () async {
                          if(messageController.text.trim().isNotEmpty){

                            state((){
                              isLoading = true;
                            });
                            
                            bool res = await PersonalNoteService.create(
                              courseId,
                              itemId,
                              messageController.text.trim()
                            );

                            state((){
                              isLoading = false;
                            });

                            if(res){
                              backRoute(arguments: true);
                            }
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.saveNote,
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }


  static viewNoteDialog(int courseId, int itemId,String text, Function onTapEdit, Function onTapAttachment, bool hasAttachment,) async {
    
    
    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context,state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.courseNote,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    Text(
                      text,
                      style: style14Regular().copyWith(color: greyA5),
                    ),

                    space(20),

                    // buttons
                    Row(
                      children: [


                        if(hasAttachment && PublicData.apiConfigData['course_notes_attachment'] == '1')...{

                          button(
                            onTap: onTapAttachment, 
                            width: 52, 
                            height: 52, 
                            text: '', 
                            bgColor: Colors.white, 
                            textColor: Colors.white,
                            borderColor: green77(),
                            iconColor: green77(),
                            iconPath: AppAssets.attachmentSvg
                          ),

                          space(0,width: 16),
                        },

                        Expanded(
                          child: button(
                            onTap: () async {
                              onTapEdit();
                            }, 
                            width: getSize().width, 
                            height: 52, 
                            text: appText.editNote,
                            bgColor: green77(), 
                            textColor: Colors.white,
                          ),
                        ),
                        
                        
                      ],
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }

  static showNoteAttachmentDialog(Function onTapRemove, Function onTapDownload, bool hasFileForDownload){
    baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            space(25),
      
            Text(
              appText.attachment,
              style: style20Bold(),
            ),
      

            // download
            if(hasFileForDownload)...{
              
              space(22),

              GestureDetector(
                onTap: (){
                  backRoute();

                  onTapDownload();          
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
            
                    SvgPicture.asset(AppAssets.download2Svg),
            
                    space(0,width: 8),
            
                    Text(
                      appText.download,
                      style: style16Regular(),
                    ),
            
                  ],
                ),
              ),
            },


            space(28),
            
            // // remove
            // GestureDetector(
            //   onTap: (){
            //     backRoute();

            //     onTapRemove();          
            //   },
            //   behavior: HitTestBehavior.opaque,
            //   child: Row(
            //     children: [
          
            //       SvgPicture.asset(AppAssets.delete2Svg),
          
            //       space(0,width: 8),
          
            //       Text(
            //         appText.remove,
            //         style: style16Regular(),
            //       ),
          
            //     ],
            //   ),
            // ),


            space(50),
      
          ],
        ),
      )
    );
  }

}