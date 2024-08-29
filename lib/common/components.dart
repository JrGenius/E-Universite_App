import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/app/models/forum_answer_model.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/models/user_model.dart';
import 'package:webinar/app/pages/main_page/home_page/cart_page/cart_page.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/forum_page/forum_answer_page.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/single_course_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/forum_service.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/download_manager.dart';
import 'package:webinar/common/utils/utils.dart';
import '../app/widgets/main_widget/home_widget/single_course_widget/learning_widget.dart';
import 'badges.dart';
import 'common.dart';
import 'enums/course_enum.dart';
import 'enums/error_enum.dart';
import 'utils/app_text.dart';
import 'utils/course_utils.dart';
import 'utils/currency_utils.dart';
import 'utils/date_formater.dart';
import '../config/assets.dart';
import '../config/colors.dart';
import '../config/styles.dart';
import '../app/models/course_model.dart';





Widget courseSliderItem(CourseModel courseData,{int horizontalPadding=20}){
  return GestureDetector(
  onTap: (){
    nextRoute(SingleCoursePage.pageName,arguments: [courseData.id, courseData.type == 'bundle']);
  },
  child: Container(
    
    padding: padding(horizontal: horizontalPadding.toDouble()),
    width: getSize().width,
    height: 215,
    
    child: ClipRRect(
      borderRadius: borderRadius(),
      child: Stack(
        children: [
    
          // image
          fadeInImage(
            courseData.image ?? '', 
            getSize().width, 
            215
          ),


          // details
          Container(
            width: getSize().width,
            height: 215,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),

            child: Column(
              children: [
                
                // price
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    margin: padding(horizontal: 12,vertical: 12),
                    padding: padding(horizontal: 12,vertical: 6),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: borderRadius(radius: 10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          offset: const Offset(0, 3),
                          blurRadius: 10
                        )
                      ]
                    ),

                    child: Text(
                      (courseData.price == 0)
                        ? appText.free
                        : CurrencyUtils.calculator(courseData.price ?? 0),
                      style: style14Regular().copyWith(color: green77()),
                    ),
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: padding(horizontal: 9, vertical: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      SizedBox(
                        width: getSize().width,
                        child: Text(
                          courseData.title ?? '',
                          style: style16Bold().copyWith(color: Colors.white),
                        ),
                      ),

                      space(4),

                      ratingBar(double.parse(courseData.rate ?? '0').round().toString()),

                      space(10),

                      // info
                      Row(
                        children: [
                          
                          ClipRRect(
                            borderRadius: borderRadius(radius: 50),
                            child: fadeInImage(
                              courseData.teacher?.avatar ?? '', 
                              20, 
                              20
                            ),
                          ),

                          space(0,width: 4),

                          Text(
                            courseData.teacher?.fullName ?? '',
                            style: style10Regular().copyWith(color: Colors.white),
                          ),


                          space(0,width: 12),

                          SvgPicture.asset(AppAssets.timeSvg),

                          space(0,width: 4),

                          Text(
                            '${durationToString(courseData.duration ?? 0)} ${appText.hours}',
                            style: style10Regular().copyWith(color: Colors.white),
                          )
                        ],
                      )

                    ],
                  ),
                )

              ],
            ),
          )
    
        ],
      ),
    ),
  ),
);

}

Widget courseSliderItemShimmer(){
  return Shimmer.fromColors(
    baseColor: greyE7,
    highlightColor: greyF8,
    child: Container(
      
      padding: padding(),
      width: getSize().width,
      height: 215,
      
      child: ClipRRect(
        borderRadius: borderRadius(),
        child: Container(
          width: getSize().width,
          height: 215,
          color: Colors.white,
        )
      ),
    ),
  );

}

Widget courseItem(CourseModel courseData,{bool isSmallSize=true,double width = 158.0,height = 200.0,double endCardPadding=16.0, bool isShowReward=false}){
  
  
  if(!isSmallSize){
    width = 220;
    height = 240;
  }

  

  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: const BoxDecoration(),
    margin: EdgeInsetsDirectional.only(end: endCardPadding),
    width: width,
    height: height,

    child: GestureDetector(
      onTap: (){
        nextRoute(SingleCoursePage.pageName, arguments: [courseData.id, courseData.type == 'bundle']);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // image
          ClipRRect(
            borderRadius: borderRadius(radius: 15),
            child: Stack(
              children: [

                fadeInImage(
                  courseData.image ?? '', 
                  width, 
                  isSmallSize ? 100 : 140
                ),

                // rate and notification and progress
                Container(
                  width: width,
                  height: isSmallSize ? 100 : 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    )
                  ),

                  child: Column(
                    children: [
                      
                      // rate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // rate
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                              start: 8,
                              end: 8,
                              bottom: 2,
                              top: 8
                            ),
                            // margin: padding(horizontal: 8,vertical: 8),
                            padding: padding(horizontal: 8,vertical: 6),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius(radius: 10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.05),
                                  offset: const Offset(0, 3),
                                  blurRadius: 10
                                )
                              ]
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppAssets.starYellowSvg,width: 13,),

                                space(0,width: 2),
                                
                                Text(
                                  courseData.rate ?? '',
                                  style: style12Regular(),
                                ),
                              ],
                            ),
                          ),


                          if(CourseUtils.checkType(courseData) == CourseType.live)...{
                            GestureDetector(
                              onTap: () async {
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
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                  start: 8,
                                  end: 8,
                                  bottom: 2,
                                  top: 8
                                ),
                                width: 28,
                                height: 28,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: borderRadius(radius: 8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.05),
                                      offset: const Offset(0, 3),
                                      blurRadius: 20
                                    )
                                  ]
                                ),

                                alignment: Alignment.center,
                                child: SvgPicture.asset(AppAssets.notificationSvg,colorFilter: ColorFilter.mode(blue64(), BlendMode.srcIn),width: 12,),
                              )
                            ),
                          }
                        ],
                      ),
                    
                      
                      const Spacer(),

                      

                      if(courseData.badges?.isNotEmpty ?? false)...{

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            margin: padding(horizontal: 8),
                            padding: padding(horizontal: 6,vertical: 4),
                            
                            decoration: BoxDecoration(
                              color: getColorFromRGBString(courseData.badges!.first.badge?.background ?? ''),
                              borderRadius: borderRadius(radius: 10),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                if(courseData.badges!.first.badge?.icon != null)...{
                                  SvgPicture.network(
                                    '${Constants.dommain}${courseData.badges!.first.badge?.icon ?? ''}',
                                    width: 16,
                                  ),

                                  space(0,width: 2),

                                }else...{
                                  space(0,width: 2),
                                },

                                Text(
                                  courseData.badges!.first.badge?.title ?? '', 
                                  style: style12Regular().copyWith(
                                    color: courseData.badges!.first.badge != null ? Color(int.parse(courseData.badges!.first.badge!.color!.substring(1, 7), radix: 16) + 0xFF000000) : null
                                  ),
                                ),
                                
                                space(0,width: 2),
                              ],
                            ),
                          ),
                        ),

                        space(7),

                      }else...{

                        if (CourseUtils.checkType(courseData) == CourseType.live)...{

                          // progress
                          Padding(
                            padding: padding(horizontal: 8,vertical: 8),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  height: 4.5,
                                  padding: padding(horizontal: 1.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: borderRadius()
                                  ),
                                  alignment: AlignmentDirectional.centerStart,

                                  child: Container(
                                    width: constraints.maxWidth * ( (courseData.studentsCount ?? 1) / (courseData.capacity ?? 1) ),
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: yellow29,
                                      borderRadius: borderRadius()
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                
                        },
                      },

                    ],
                  ),
                )



                
              ],  
            ),
          ),

          // details
          Expanded(
            child: Padding(
              padding: padding(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  space(10),
              
                  // title
                  Text(
                    courseData.title ?? '',
                    style: style14Bold().copyWith(height: 1.3),
                    maxLines: 2,
                  ),
                  
                  const Spacer(),
                  const Spacer(),
                  
                  // name and date and time
                  SizedBox(
                    width: width,
                    child: Row(
                      children: [
                  
                        SizedBox(
                          width: (width / 2.3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppAssets.profileSvg),
                              
                              space(0,width: 4),
                                        
                              Expanded(
                                child: Text(
                                  courseData.teacher?.fullName ?? '',
                                  style: style10Regular().copyWith(color: greyB2),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                                        
                              space(0,width: 8),
                            ],
                          ),
                        ),
              
                        if(CourseUtils.checkType(courseData) == CourseType.live)...{
                          if(courseData.startDate != null)...{
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppAssets.calendarSvg),
                                
                                space(0,width: 4),
                
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(courseData.startDate! *  1000, isUtc: true).toDate(),
                                  style: style10Regular().copyWith(color: greyB2),
                                ),
                                
                              ],
                            ),
                          }
                          
                        }else if(CourseUtils.checkType(courseData) == CourseType.video)...{
              
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppAssets.timeSvg,colorFilter: ColorFilter.mode(greyB2, BlendMode.srcIn)),
                              
                              space(0,width: 4),
              
                              Text(
                                '${durationToString(courseData.duration ?? 0)} ${appText.hours}',
                                style: style10Regular().copyWith(color: greyB2),
                              ),
                              
                            ],
                          ),
              
                        },
              
                      ],
                    ),
                  ),
              
                  const Spacer(),
              
                  // price and type
                  SizedBox(
                    width: width,
                    child: Row(
                      children: [

                        if(isShowReward)...{
                          Text(
                            courseData.points?.toString() ?? '-',
                            style: style14Regular().copyWith(color: yellow29),
                          )
                        }else...{

                          Text(
                            (courseData.price == 0)
                              ? appText.free
                              : CurrencyUtils.calculator(courseData.price ?? 0),
                            style: style12Regular().copyWith(
                              color: (courseData.discountPercent ?? 0) > 0 ? greyCF : green77(),
                              decoration: (courseData.discountPercent ?? 0) > 0 ? TextDecoration.lineThrough : TextDecoration.none,
                              decorationColor: (courseData.discountPercent ?? 0) > 0 ? greyCF : green77(),
                            ),
                          ),
                        },

                        if((courseData.discountPercent ?? 0) > 0)...{
                          space(0,width: 8),

                          Text(
                            CurrencyUtils.calculator(
                              (courseData.price ?? 0) - ((courseData.price ?? 0) * (courseData.discountPercent ?? 0) ~/ 100)
                            ),
                            style: style14Regular().copyWith(
                              color: green77(),
                            ),
                          ),
                        },

                        const Spacer(),

                        if((courseData.discountPercent ?? 0) > 0)...{
                          Badges.off((courseData.discountPercent ?? 0).toString())

                        }else if(CourseUtils.checkType(courseData) == CourseType.live)...{
                          Badges.liveClass(),

                        }else if(courseData.label == 'Course')...{
                          Badges.course(),

                        }else if(courseData.label == 'Finished')...{
                          Badges.finished(),

                        }else if(courseData.label == 'In Progress')...{
                          Badges.inProgress(),

                        }else if(courseData.label == 'Text course')...{
                          Badges.textClass(),

                        }else if(courseData.label == 'Not conducted')...{
                          Badges.notConducted(),
                        }


                      ],
                    ),
                  ),
              
                  // const Spacer(),

                ],
              ),
            ),
          ),


          

        ],
      ),
    ),
  );

}

Widget courseItemVertically(CourseModel courseData,{bool isSmallSize=true,double height=85,double bottomMargin=16,bool ignoreTap=false, bool isShowReward=false, double? imageHeight}){
  
  return Container(
    margin: EdgeInsetsDirectional.only(bottom: bottomMargin),
  
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: borderRadius()
    ),
  
    padding: padding(horizontal: 8,vertical: 8),
    width: getSize().width,
  
    child: GestureDetector(
      onTap: (){
        if(!ignoreTap){
          nextRoute(SingleCoursePage.pageName, arguments: [courseData.id, courseData.type == 'bundle']);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
  
          // image
          ClipRRect(
            borderRadius: borderRadius(radius: 15),
            child: Stack(
              children: [
  
                fadeInImage(
                  courseData.image ?? '', 
                  135, 
                  imageHeight ?? height
                ),
  
                // rate and notification and progress
                Positioned.fill(
                  child: Container(
  
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.4),
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                      )
                    ),
  
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        // rate
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                    
                            if((courseData.discountPercent ?? 0) > 0)...{
                              Container(
                                padding: padding(horizontal: 5,vertical: 5),
                                child: Badges.off((courseData.discountPercent ?? 0).toString(),isRedBg: true),
                              )
                              
                            },
                            
                                    
                                    
                            if(CourseUtils.checkType(courseData) == CourseType.live)...{
                              GestureDetector(
                                onTap: () async {
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
                                    
                                  }catch(_){}
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  margin: padding(horizontal: 8,vertical: 8),
                                  width: 28,
                                  height: 28,
                                    
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: borderRadius(radius: 8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.05),
                                        offset: const Offset(0, 3),
                                        blurRadius: 20
                                      )
                                    ]
                                  ),
                                    
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppAssets.notificationSvg,colorFilter: ColorFilter.mode(blue64(), BlendMode.srcIn),width: 12,),
                                )
                              ),
                            }
                          ],
                        ),
                      
                                    
                        

                        if(courseData.badges?.isNotEmpty ?? false)...{

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              margin: padding(horizontal: 8),
                              padding: padding(horizontal: 6,vertical: 4),
                              
                              decoration: BoxDecoration(
                                color: getColorFromRGBString(courseData.badges!.first.badge?.background ?? ''),
                                borderRadius: borderRadius(radius: 10),
                              ),

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  if(courseData.badges!.first.badge?.icon != null)...{
                                    SvgPicture.network(
                                      '${Constants.dommain}${courseData.badges!.first.badge?.icon ?? ''}',
                                      width: 16,
                                    ),

                                    space(0,width: 2),

                                  }else...{
                                    space(0,width: 2),
                                  },

                                  Text(
                                    courseData.badges!.first.badge?.title ?? '', 
                                    style: style12Regular().copyWith(
                                      color: courseData.badges!.first.badge != null ? Color(int.parse(courseData.badges!.first.badge!.color!.substring(1, 7), radix: 16) + 0xFF000000) : null
                                    ),
                                  ),
                                  
                                  space(0,width: 2),
                                ],
                              ),
                            ),
                          ),

                          space(2),

                        }else...{
                          if (CourseUtils.checkType(courseData) == CourseType.live)...{
                                    
                            // progress
                            Container(
                              width: 130,
                              padding: padding(horizontal: 8,vertical: 8),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Container(
                                    width: constraints.maxWidth,
                                    height: 4.5,
                                    padding: padding(horizontal: 1.5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: borderRadius()
                                    ),
                                    alignment: AlignmentDirectional.centerStart,
                                      
                                    child: Container(
                                      width: constraints.maxWidth * ( (courseData.studentsCount ?? 0) / (courseData.capacity ?? 0) ),
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: yellow29,
                                        borderRadius: borderRadius()
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            
                                    
                          },
                        },
                      
                      ],
                    ),
                  ),
                )
  
  
  
                
              ],  
            ),
          ),
  
          // details
          Expanded(
            child: SizedBox(
              height: height,
              child: Padding(
                padding: padding(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                                    
                    // title
                    Text(
                      courseData.title ?? '',
                      style: style14Bold().copyWith(height: 1.3),
                      maxLines: 2,
                    ),
                    
                    if(courseData.reservedMeeting != null)...{

                      space(5),

                      Container(

                        padding: padding(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyE7),
                          borderRadius: borderRadius()
                        ),  

                        child: MarqueeWidget(
                          child: Text(
                            courseData.reservedMeeting ?? '',
                            style: style10Regular(),
                          ),
                        )
                      ),

                      space(5),
                      
                      // reserved Meeting User TimeZone
                      Container(

                        padding: padding(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: red49),
                          borderRadius: borderRadius()
                        ),  

                        child: MarqueeWidget(
                          child: Text(
                            courseData.reservedMeetingUserTimeZone ?? '',
                            style: style10Regular().copyWith(color: red49),
                          ),
                        )
                      ),

                      space(5),

                    },
                    
                    // name and date and time
                    ratingBar(courseData.rate ?? '0'),
                
                    // price and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        if(CourseUtils.checkType(courseData) == CourseType.live)...{

                          if(courseData.startDate != null)...{
                            // date
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppAssets.calendarSvg),
                                
                                space(0,width: 4),
                
                                Text(
                                  courseData.startDate == null
                                  ? ''
                                  : DateTime.fromMillisecondsSinceEpoch((courseData.startDate ?? 0) *  1000, isUtc: true).toDate(),
                                  style: style10Regular().copyWith(color: greyB2),
                                ),
                                
                              ],
                            ),

                          }else...{
                            const SizedBox()
                          },

                        }else...{

                          if(courseData.createdAt != null)...{
                            // date
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppAssets.calendarSvg),
                                
                                space(0,width: 4),
                
                                Text(
                                  courseData.createdAt == null
                                  ? ''
                                  : DateTime.fromMillisecondsSinceEpoch((courseData.createdAt ?? 0) *  1000, isUtc: true).toDate(),
                                  style: style10Regular().copyWith(color: greyB2),
                                ),
                                
                              ],
                            ),

                          }else...{
                            const SizedBox()
                          },

                        },
                        
                        
                        // price or reward
                        if(isShowReward)...{
                          Text(
                            courseData.points?.toString() ?? '-',
                            style: style14Regular().copyWith(color: yellow29),
                          )
                        }else...{

                          Row(
                            children: [
                  
                              Text(
                                (courseData.price == 0)
                                  ? appText.free
                                  : CurrencyUtils.calculator(courseData.price ?? 0),
                                style: style12Regular().copyWith(
                                  color: (courseData.discountPercent ?? 0) > 0 ? greyCF : green77(),
                                  decoration: (courseData.discountPercent ?? 0) > 0 ? TextDecoration.lineThrough : TextDecoration.none,
                                  decorationColor: (courseData.discountPercent ?? 0) > 0 ? greyCF : green77(),
                                ),
                              ),
                  
                              if((courseData.discountPercent ?? 0) > 0)...{
                                space(0,width: 8),
                  
                                Text(
                                  CurrencyUtils.calculator(
                                    (courseData.price ?? 0) - ((courseData.price ?? 0) * (courseData.discountPercent ?? 0) ~/ 100)
                                  ),
                                  style: style14Regular().copyWith(
                                    color: green77(),
                                  ),
                                ),
                              },
                              
                            ],
                          ),
                        }
  
  
  
                        
                      ],
                    ),
                
                
                  ],
                ),
              ),
            ),
          ),
  
  
          
  
        ],
      ),
    ),
  );

}

Widget input(TextEditingController controller,FocusNode node,String hint,{String? iconPathLeft,bool isNumber=false,bool isCenter=false,int letterSpacing=1,bool isReadOnly=false,Function? onTap,int height=52,bool isPassword=false,Function? onTapLeftIcon, Function? obscureText,int leftIconSize=14,String? Function(String?)? validator,bool isError=false,Function(String)? onChange,int fontSize=16,Color leftIconColor=const Color(0xff6E6E6E),double radius = 20,int? maxLength,bool isBorder=false,Color fillColor=Colors.white,int? maxLine,String? title, String? rightIconPath, int rightIconSize=14, Function? onTapRightIcon}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [

      if(title != null)...{

        Padding(
          padding: padding(horizontal: 6),
          child: Text(
            title,
            style: style12Regular().copyWith(color: greyA5),
          ),
        ),

        space(8),
      },

      Theme(
        data: Theme.of(navigatorKey.currentContext!).copyWith(
          colorScheme: ColorScheme.light(error: red49)
        ),
        child: SizedBox(
          height: height.toDouble(),
          child: TextFormField(
            
            controller: controller,
            focusNode: node,
            cursorColor: green50,
            cursorHeight: isPassword ? 10 : 15,
            
            readOnly: isReadOnly,
            onTap: (){
              if(onTap != null){
                onTap();
              }
            },
          
            onChanged: (text){
              if(onChange != null){
                onChange(text);
              }
            },
            
            validator: validator,
            obscureText: isPassword,
          
            style: style14Regular().copyWith(
              letterSpacing: letterSpacing.toDouble(),
              fontSize: fontSize.toDouble(),
              height: 1,
              color: greyB2
            ),
            keyboardType: TextInputType.text,
            textAlign: isCenter 
            ? TextAlign.center 
            : TextAlign.start,
          
          
            autofillHints: const [ AutofillHints.oneTimeCode ],
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
              
              if(isNumber)...{
                FilteringTextInputFormatter.digitsOnly
              }
            ],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              
              hintText: hint,
              hintStyle: style14Regular().copyWith(
                letterSpacing: 0,
                fontSize: fontSize.toDouble(),
                color: greyB2,
                height: .8
              ),

              prefixIconConstraints: BoxConstraints.expand(
                width: iconPathLeft == null ? 22 : 50
              ),    
              prefixIcon: iconPathLeft != null
                ? GestureDetector(
                  onTap: () {
                    if(onTapLeftIcon!=null){
                      onTapLeftIcon();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      space(0,width: 22),
                      
                      SvgPicture.asset(
                        iconPathLeft,
                        width: leftIconSize.toDouble(),
                      ),
              
                    ],
                  ),
                )
                : const SizedBox(),
              
              suffixIconConstraints: BoxConstraints.expand(
                width: rightIconPath == null ? 22 : 50
              ),    
              suffixIcon: rightIconPath != null
                ? GestureDetector(
                  onTap: () {
                    if(onTapRightIcon!=null){
                      onTapRightIcon();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      space(0,width: 22),
                      
                      SvgPicture.asset(
                        rightIconPath,
                        width: rightIconSize.toDouble(),
                      ),
              
                    ],
                  ),
                )
                : const SizedBox(),
          
              fillColor: fillColor,
              filled: true,
            
              border: OutlineInputBorder(
                borderRadius: borderRadius(radius: radius),
                borderSide: BorderSide(
                  color: isBorder ? greyE7 : Colors.transparent,
                  width: 1
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius(radius: radius),
                borderSide: BorderSide(
                  color: red49,
                  width: 0
                ),
              ),
            
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius(radius: radius),
                borderSide: BorderSide(
                  color: red49,
                  width: 0
                )
              ),
          
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius(radius: radius),
                borderSide: BorderSide(
                  color: isBorder ? greyE7 : Colors.transparent,
                  width: 1
                )
              ),
          
              focusedBorder: OutlineInputBorder(
          
                borderRadius: borderRadius(radius: radius),
                borderSide: BorderSide(
                  color: isBorder ? greyE7 : Colors.transparent,
                  width: 1
                ),
              ),
              
            ),
          ),
        ),
      ),
    ],
  );
}

Widget descriptionInput(TextEditingController controller,FocusNode node,String hint,{String? iconPathLeft,bool isNumber=false,bool isCenter=false,int letterSpacing=1,bool isReadOnly=false,Function? onTap,int height=52,bool isPassword=false,Function? onTapLeftIcon, Function? obscureText,int leftIconSize=14,String? Function(String?)? validator,bool isError=false,Function(String)? onChange,int fontSize=16,Color leftIconColor=const Color(0xff6E6E6E),double radius = 20,int? maxLength,bool isBorder=false,Color fillColor=Colors.white,int maxLine=8}){
  return Theme(
    data: Theme.of(navigatorKey.currentContext!).copyWith(
      colorScheme: ColorScheme.light(error: red49)
    ),
    child: TextFormField(
      
      controller: controller,
      focusNode: node,
      cursorColor: green50,

      maxLines: maxLine,
      
      readOnly: isReadOnly,
      onTap: (){
        if(onTap != null){
          onTap();
        }
      },
    
      onChanged: (text){
        if(onChange != null){
          onChange(text);
        }
      },
      
      validator: validator,
      obscureText: isPassword,
    
      style: style14Regular().copyWith(
        letterSpacing: letterSpacing.toDouble(),
        fontSize: fontSize.toDouble(),
        height: 1,
        color: greyB2
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      textAlign: isCenter 
      ? TextAlign.center 
      : isNumber  
        ? TextAlign.end 
        : TextAlign.start,
    
    
      // autofillHints: const [ AutofillHints.oneTimeCode ],
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength)
      ],
      decoration: InputDecoration(
        
        hintText: hint,
        hintStyle: style14Regular().copyWith(
          letterSpacing: 0,
          fontSize: 14,
          color: greyA5,
          height: 1.3
        ),

        contentPadding: padding(horizontal: 12,vertical: 12),

        // prefixIconConstraints: BoxConstraints.expand(
        //   width: iconPathLeft == null ? 22 : 50
        // ),    
        // prefixIcon: iconPathLeft != null
        //   ? GestureDetector(
        //     onTap: () {
        //       if(onTapLeftIcon!=null){
        //         onTapLeftIcon();
        //       }
        //     },
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         space(0,width: 22),
                
        //         SvgPicture.asset(
        //           iconPathLeft,
        //           width: leftIconSize.toDouble(),
        //         ),
        
        //       ],
        //     ),
        //   )
        //   : const SizedBox(),
    
        fillColor: fillColor,
        filled: true,
      
        border: OutlineInputBorder(
          borderRadius: borderRadius(radius: radius),
          borderSide: BorderSide(
            color: isBorder ? greyE7 : Colors.transparent,
            width: 1
          ),
        ),
        
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius: radius),
          borderSide: BorderSide(
            color: red49,
            width: 0
          ),
        ),
      
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius: radius),
          borderSide: BorderSide(
            color: red49,
            width: 0
          )
        ),
    
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius: radius),
          borderSide: BorderSide(
            color: isBorder ? greyE7 : Colors.transparent,
            width: 1
          )
        ),
    
        focusedBorder: OutlineInputBorder(
    
          borderRadius: borderRadius(radius: radius),
          borderSide: BorderSide(
            color: isBorder ? greyE7 : Colors.transparent,
            width: 1
          ),
        ),
        
      ),
    ),
  );
}

Widget horizontalCategoryItem(Color color,String icon, String title,String courseCount,Function onTap){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      width: getSize().width * .7,
      margin: const EdgeInsetsDirectional.only(end: 16),
      padding: padding(horizontal: 16,vertical: 16),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(radius: 15),
      ),
  
      child: Row(
        children: [
  
          Container(
            width: 68,
            height: 68,
  
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius(radius: 8),
            ),
            alignment: Alignment.center,
  
            child: Image.network(icon,width: 24),
          ),
  
          space(0,width: 16),
  
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
  
              Text(
                title,
                style: style14Bold(),
              ),
  
              space(4),
              
              Text(
                '$courseCount ${appText.courses}',
                style: style12Regular().copyWith(color: greyA5),
              ),
  
            ],
          )
  
          
        ],
      ),
    
    ),
  );
}

Widget horizontalNoticesItem(Color color, String icon, String title, String name, String date,Function onTap){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      width: getSize().width,
      padding: padding(horizontal: 16,vertical: 16),
      margin: const EdgeInsets.only(bottom: 16),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(radius: 15),
      ),
  
      child: Row(
        children: [
          
          // icom
          Container(
            width: 58,
            height: 58,
      
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius(radius: 8),
            ),
            alignment: Alignment.center,
      
            child: SvgPicture.asset(icon,width: 24, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          ),
      
          space(0,width: 16),
      
          // details  
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // title
                Text(
                  title,
                  style: style14Bold(),
                ),
            
                space(12),
                
                // username and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    // user name
                    Row(
                      children: [
                         SvgPicture.asset(AppAssets.profileSvg,width: 11),
                
                        space(0,width: 4),
                
                        Text(
                          name,
                          style: style12Regular().copyWith(color: greyA5),
                        ),
                      ],
                    ),
                
                    // date
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.calendarSvg,width: 8,),
                
                        space(0,width: 4),
                
                        Text(
                          date,
                          style: style12Regular().copyWith(color: greyA5),
                        ),
                      ],
                    ),

                    const SizedBox()
                
                  ],
                )
            
              ],
            ),
          )
      
          
        ],
      ),
    
    ),
  );
}

Widget horizontalChapterItem(Color color,String icon, String title,String subTitle,Function onTap,{double width=24,double height=24,bool isFixWidth=false,bool transparentColor=false, Color? iconColor}){
  
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      height: 80,
      width: isFixWidth ? getSize().width : 290,
      margin: EdgeInsetsDirectional.only(end: isFixWidth ? 0 : 16),
      padding: padding(horizontal: 12),
      
      decoration: BoxDecoration(
        color: transparentColor ? Colors.transparent : Colors.white,
        borderRadius: borderRadius(radius: 15),
      ),
  
      child: Row(
        children: [
  
          Container(
            width: 56,
            height: 56,
  
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius(radius: 10),
            ),
            alignment: Alignment.center,
  
            child: SvgPicture.asset(icon, width: width, height: height, colorFilter: iconColor != null ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null),
          ),
  
          space(0,width: 16),
  
          Builder(
            builder: (context) {
              return Container(
                constraints: BoxConstraints(
                  minWidth: 50,
                  maxWidth: getSize().width
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: isFixWidth ? getSize().width * .5 : 180,
                      ),
                      child: Text(
                        title,
                        style: style14Bold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                    space(4),
                    
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: getSize().width * .5,
                      ),
                      child: Text(
                        subTitle,
                        style: style12Regular().copyWith(color: greyA5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                  ],
                ),
              );
            }
          ),
  
          
        ],
      ),
    
    ),
  );
}

Widget switchButton(String title,bool state,Function(bool value) onChangeState){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

      Text(
        title,
        style: style14Regular().copyWith(color: grey3A),
      ),

      GestureDetector(
        onTap: (){
          onChangeState(!state);
        },
        onHorizontalDragUpdate: (details) {
          
          if(details.delta.dx < 0){
            onChangeState(true);
          }else{
            onChangeState(false);
          }

        },
        behavior: HitTestBehavior.opaque,
        child: Container( // for touch
          alignment: Alignment.center,
          height: 25,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 32,
            height: 6,
            
            clipBehavior: Clip.none,
        
            decoration: BoxDecoration(
              color: state ? green77() : greyE7,
              borderRadius: borderRadius(radius: 30),
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                
                AnimatedPositionedDirectional(
                  top: -4,
                  end: state ? -2 : 18,
                  bottom: -4,
                  duration: const Duration(milliseconds: 150),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4
                      ),
                      color: state ? green77() : greyE7,
                      boxShadow: [
                        boxShadow(greyD0.withOpacity(.4), blur: 10, y: 3)
                      ]
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      
      ),
    ],
  );
}

Widget radioButton(String title,bool state,Function(bool value) onChangeState){
  return GestureDetector(
    onTap: (){
      onChangeState(!state);
    },
    behavior: HitTestBehavior.opaque,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 6
            ),
            color: state ? green77() : greyE7,
            boxShadow: [
              boxShadow(greyD0.withOpacity(.38),blur: 10,y: 3)
            ]
          ),
        ),

        space(0,width: 8),

        Text(
          title,
          style: style14Regular().copyWith(color: grey3A),
        ),

      ],
    ),
  );
}

Widget checkButton(String title,bool state,Function(bool value) onChangeState){
  return GestureDetector(
    onTap: (){
      onChangeState(!state);
    },
    behavior: HitTestBehavior.opaque,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          title,
          style: style14Regular().copyWith(color: grey3A),
        ),



        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: borderRadius(radius: 5),
            border: Border.all(
              color: state ? green77() : greyCF,
            ),
            color: state ? green77() : Colors.white,
          ),

          alignment: Alignment.center,
          child: SvgPicture.asset(AppAssets.checkSvg),
        ),


      ],
    ),
  );
}

AppBar appbar({required String title,Function onTapLeftIcon=backRoute, String? leftIcon=AppAssets.backSvg, bool isBasket=false, Function onTapRightIcon=backRoute, String? rightIcon,double? rightWidth}){

  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
    titleSpacing: 20, 
    backgroundColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,

    automaticallyImplyLeading: false,
    centerTitle: true,

    title: Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9, top: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            if(leftIcon == null)...{
              const SizedBox(width: 52,height: 52)
            }else...{
              closeButton(leftIcon, onTap: onTapLeftIcon),
            },

            Expanded(
              child: Padding(
                padding: padding(horizontal: 12),
                child: Center(
                  child: Text(
                    title,
                    style: style16Regular().copyWith(color: grey3A),
                  ),
                ),
              ),
            ),
      
            if(isBasket)...{
              
              Consumer<UserProvider>(
                builder: (context, provider, child) {
                  
                  return GestureDetector(
                    onTap: (){
                      nextRoute(CartPage.pageName);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 52,
                      height: 52,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius(radius: 15),
                      ),


                      child: Stack(
                        children: [
                          
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(AppAssets.basketSvg,colorFilter: ColorFilter.mode(blue64(), BlendMode.srcIn),),
                          ),

                          if(provider.cartData?.items?.isNotEmpty ?? false)...{
                            Positioned(
                              top: 17,
                              right: 13,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: red49
                                ),
                              )
                            )
                          }
                          
                        ],
                      ),
                    ),
                  );
                },
              ),

            }else if(rightIcon != null)...{
              closeButton(rightIcon, onTap: onTapRightIcon, width: rightWidth),
            }else...{
              const SizedBox(width: 52,height: 52)
            }
      
          ],
        ),
      ),
    ),
  );
}

Widget button({required Function onTap,required double? width,required double height , required String text, required Color bgColor, required Color textColor, Color? iconColor,Color? borderColor, int raduis= 20, BoxShadow? boxShadow,String? iconPath,int fontSize=14,bool isLoading=false,Color? loadingColor,int horizontalPadding=0, int? icWidth}){
  return GestureDetector(
    
    onTap: (){
      onTap();
    },
    
    behavior: HitTestBehavior.opaque,

    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isLoading ? height.toDouble() : width?.toDouble(),
      height: height.toDouble(),
      alignment: Alignment.center,
      padding: padding(horizontal: isLoading ? 0 : horizontalPadding.toDouble()),

      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1
        ),
        borderRadius: borderRadius(
          radius: isLoading ? 100 : raduis.toDouble()
        ),
        boxShadow: [
          if(boxShadow != null)...{
            boxShadow
          }
        ]
      ),

      child: AnimatedCrossFade(
        firstChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            if(iconPath != null)...{
              
              if(text.isNotEmpty)...{
                space(0,width: 2.5),
              },
              
              SvgPicture.asset(
                iconPath,
                colorFilter: iconColor != null ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null,
                width: icWidth?.toDouble(),
              ),

              if(text.isNotEmpty)...{
                space(0, width: 5.5),
              }

            },

            if(text.isNotEmpty)...{
              Text(
                text,
                style: style14Regular().copyWith(
                  fontSize: fontSize.toDouble(),
                  color: textColor
                ),
              ),
            }

          ],
        ), 
        secondChild: loading(color: loadingColor ?? Colors.white), 
        crossFadeState: isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst, 
        duration:  const Duration(milliseconds: 200),
      )
    ),

  );
}

Widget emptyState(String icon,String title,String desc,{bool isBottomPadding=true}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
  
      SvgPicture.asset(icon),
  
      space(20),
  
      Text(
        title,
        style: style20Bold(),
      ),
  
      space(4),
  
      Padding(
        padding: padding(horizontal: 50),
        child: Text(
          desc,
          style: style14Regular().copyWith(color: grey5E),
          textAlign: TextAlign.center,
        ),
      ),

      space(isBottomPadding ? getSize().height * .1 : 0)
  
    ],
  );
}


showSnackBar(ErrorEnum type,String? title,{String? desc,int time=3,int fontSize=15,BuildContext? context}){
  ScaffoldMessenger.of(context ?? navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: directionality(
      child: Container(
        width: getSize().width,
        padding: padding(horizontal: 10, vertical: 10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(),
          border: Border.all(
            color: greyE7,
            width: 1 
          )
        ),

        child: Row(
          children: [

            Container(
              width: 45,
              height: 45,
              
              decoration: BoxDecoration(
                color: type == ErrorEnum.success
                ? green77()
                : type == ErrorEnum.error
                  ? red49
                  : yellow29,
                
                shape: BoxShape.circle
              ),
              alignment: Alignment.center,

              child: SvgPicture.asset(
                type == ErrorEnum.success
                ? AppAssets.checkSvg
                : type == ErrorEnum.error
                  ? AppAssets.clearSvg
                  : AppAssets.alertSvg
              ),

            ),

            space(0,width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(title != null)...{
                    Text(
                      title,
                      style: style14Bold(),
                    )
                  },
                  
                  if(desc != null)...{
                    Text(
                      desc,
                      style: style12Regular().copyWith(color: greyB2),
                    )
                  },

                ],
              )
            )

          ],
        ),

      )
    ),
    
    duration:  Duration(seconds: time),
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}

closeSnackBar(){
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
}

Widget userProfileCard(UserModel user,Function onTap){  
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      width: 155,
      height: 195,
      padding: padding(horizontal: 14,vertical: 14),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
      ),

      child: Column(
        children: [
          // meet status
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: user.meetingStatus == 'no' 
                  ? red49.withOpacity(.3)
                  : user.meetingStatus == 'available' 
                    ? green77().withOpacity(.3)
                    : greyCF.withOpacity(.3)
              ),

              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.calendarSvg,
                width: 11,
                colorFilter: ColorFilter.mode(
                  user.meetingStatus == 'no' 
                  ? red49
                  : user.meetingStatus == 'available' 
                    ? green77()
                    : greyCF, 
                  BlendMode.srcIn
                ),
              ),
            ),
          ),


          Expanded(
            child: Column(
              children: [
          
                ClipRRect(
                  borderRadius: borderRadius(radius: 100),
                  child: fadeInImage(user.avatar ?? '', 70, 70),
                ),
          
                const Spacer(flex: 1),
          
                Text(
                  user.fullName ?? '',
                  style: style14Regular(),
                ),

                space(2),
                
                Text(
                  user.bio ?? '',
                  style: style10Regular().copyWith(color: greyA5),
                  maxLines: 1,
                ),

                space(8),

                ratingBar(user.rate ?? '0'),
          
                const Spacer(flex: 2),
          
              ],
            ),
          )
        ],
      ),

    ),
  );
}

Widget userCard(String image, String title,String desc, String date, String price, String type,Function onTap, {Time? time, String? userGrade, String? gradeStatus, int imageWidth=70, int paddingValue=14, int titleAndDescSpace=2, Function? onTapSubtitle}){  
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      width: getSize().width,
      height: 100,
      padding: padding(horizontal: paddingValue.toDouble(), vertical: paddingValue.toDouble()),
      margin: const EdgeInsets.only(bottom: 15),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
      ),

      child: Row(
        children: [
        
          ClipRRect(
            borderRadius: borderRadius(radius: 10),
            child: fadeInImage(image, imageWidth.toDouble(), 100),
          ),

          space(0, width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                space(4),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Text(
                        title,
                        style: style14Regular(),
                      ),
                    ),

                    if(type == 'webinar')...{
                      Badges.course(),
                    }else if(type == 'pending')...{
                      Badges.pending(),
                    }else if(type == 'open')...{
                      Badges.open(),
                    }else if(type == 'waiting')...{
                      Badges.waiting(),
                    }
                  ],
                ),

                space(titleAndDescSpace.toDouble()),
                
                IgnorePointer(
                  ignoring: onTapSubtitle == null,
                  child: GestureDetector(
                    onTap: (){
                      if(onTapSubtitle != null){
                        onTapSubtitle();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      desc,
                      style: style10Regular().copyWith(color: greyA5),
                      maxLines: 1,
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    // date
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.calendarSvg),
                        
                        space(0,width: 4),

                        Text(
                          date,
                          style:style10Regular().copyWith(color: greyA5), 
                        )
                      ],
                    ),

                    if(time != null)...{
                      // time
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.timeSvg, colorFilter: ColorFilter.mode(greyA5, BlendMode.srcIn),),
                          
                          space(0,width: 4),

                          Text(
                            '${time.start}-${time.end}',
                            style:style10Regular().copyWith(color: greyA5), 
                          ),
                        ],
                      ),

                      space(0)
                    },


                    if(price.isNotEmpty)...{
                      Text(
                        price,
                        style: style16Regular().copyWith(color: green77()), 
                      )
                    },

                    
                    if(userGrade != null)...{
                      // Grade
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.badgeSvg, 
                            colorFilter: ColorFilter.mode(
                              gradeStatus == 'passed'
                              ? green77()
                              : gradeStatus == 'waiting'
                                ? yellow29
                                : gradeStatus == 'failed'
                                  ? red49
                                  : yellow29, 
                              BlendMode.srcIn
                            ),
                            width: 9,
                          ),
                          
                          space(0,width: 4),

                          Text(
                            userGrade,
                            style: style12Regular().copyWith(
                              color: gradeStatus == 'passed'
                                ? green77()
                                : gradeStatus == 'waiting'
                                  ? yellow29
                                  : gradeStatus == 'failed'
                                    ? red49
                                    : yellow29,
                            ), 
                          ),
                          

                          // space(0,width: 12),
                        ],
                      ),

                    },

                  ],
                ),

                space(4),
              ],
            ),
          )
        ],
      ),

    ),
  );

}

Widget tabBar(Function(int) onChangeTab, TabController tabController,List<Widget> tab,{double horizontalPadding = 14}){
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: TabBar(
      onTap: onChangeTab,
      isScrollable: true,
      controller: tabController,
      physics: const BouncingScrollPhysics(),
      padding: padding(horizontal: horizontalPadding),                            

      indicator: RoundedTabIndicator(),
  
      labelStyle: style14Regular(),
      unselectedLabelStyle: style14Regular(),
      labelColor: grey3A,
      dividerColor: Colors.transparent,
      labelPadding: padding(horizontal: 10),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              
      tabs: tab
    ),
  );
                    
}



Widget blogItem(BlogModel blog,Function onTap){
  
  return GestureDetector(
    onTap: (){
      onTap();
    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: getSize().width,
      padding: padding(horizontal: 10,vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(radius: 15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // image
          Hero(
            tag: blog.id!,
            child: ClipRRect(
              borderRadius: borderRadius(radius: 10),
              child: Stack(
                children: [

                  fadeInImage(blog.image ?? '', getSize().width, 200),
            
                  Container(
                    padding: padding(horizontal: 12,vertical: 12),
                    width: getSize().width,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.7),
                          Colors.black.withOpacity(.1),
                          Colors.black.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                      )
                    ),
          
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
          
                        ClipRRect(
                          borderRadius: borderRadius(radius: 100),
                          child: fadeInImage(blog.author?.avatar ?? '', 32, 32),
                        ),
          
                        space(0,width: 8),
          
                        Text(
                          blog.author?.fullName ?? '',
                          style: style14Regular().copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                

                  if(blog.badges?.isNotEmpty ?? false)...{
                    space(3),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        margin: padding(horizontal: 12,vertical: 12),
                        padding: padding(horizontal: 6,vertical: 4),
                        
                        decoration: BoxDecoration(
                          color: getColorFromRGBString(blog.badges!.first.badge?.background ?? ''),
                          borderRadius: borderRadius(radius: 10),
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            if(blog.badges!.first.badge?.icon != null)...{
                              SvgPicture.network(
                                '${Constants.dommain}${blog.badges!.first.badge?.icon ?? ''}',
                                width: 16,
                              ),

                              space(0,width: 2),

                            }else...{
                              space(0,width: 2),
                            },

                            Text(
                              blog.badges!.first.badge?.title ?? '', 
                              style: style12Regular().copyWith(
                                color: Color(int.parse(blog.badges!.first.badge!.color!.substring(1, 7), radix: 16) + 0xFF000000)
                              ),
                            ),
                            
                            space(0,width: 2),
                          ],
                        ),
                      ),
                    )
                  },
                ],
              ),
            ),
          ),

          space(16),

          Text(
            blog.title ?? '',
            style: style14Bold(),
          ),

          space(5),

          HtmlWidget(
            blog.description ?? '',
            textStyle: style12Regular().copyWith(color: greyA5,height: 1.6),
          ),

          space(10),

          Row(
            children: [
              
              Row(
                children: [
                  SvgPicture.asset(AppAssets.calendarSvg),

                  space(0,width: 5),

                  Text(
                    timeStampToDate((blog.createdAt ?? 0) * 1000).toString(),
                    style: style10Regular().copyWith(color: greyA5),
                  )
              
                ],
              ),

              space(0,width: 20),
              
              Row(
                children: [
                  SvgPicture.asset(AppAssets.commentSvg),

                  space(0,width: 5),

                  Text(
                    '${blog.commentCount} ${appText.comments}',
                    style: style10Regular().copyWith(color: greyA5),
                  )
              
                ],
              ),

            ],
          )


        ],
      ),
    ),
  );

}

Widget userProfile(UserModel user,{bool showRate=false,String? customRate, String? customSubtitle, bool isBoldTitle=false, bool isBackground=false, bool isBoxLimited=false}){
  return Container(
    padding: isBackground ? padding(horizontal: 12, vertical: 12) : null,
    decoration: isBackground
      ? BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(radius: 10)
        )
      : null,

    width: isBoxLimited ? 240 : null,

    child: Row(
      children: [
  
        ClipRRect(
          borderRadius: borderRadius(radius: 100),
          child: fadeInImage(user.avatar ?? '', 40, 40)
        ),
  
        space(0,width: 6),
  
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
  
            Container(
              constraints: isBoxLimited
                ? const BoxConstraints(
                    maxWidth: 150
                  )
                : const BoxConstraints(),
              child: Text(
                user.fullName ?? '',
                style: !isBoldTitle ? style14Regular() : style14Bold(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
  
            
            if(showRate)...{
  
              space(3),
  
              ratingBar(customRate ?? user.rate.toString()),
            }else if(customSubtitle != null)...{
              
              space(6),
  
              Text(
                customSubtitle,
                style: style12Regular().copyWith(color: greyA5),
              ),
            }else...{
              Text(
                user.roleName ?? '',
                style: style14Regular().copyWith(color: greyA5),
              ),
            }
  
          ],
        )
      ],
    ),
  );
}


Widget dropDown(String hint, String itemSelected, List<String> items, Function onTapOpenBox,Function(String newValue,int index) onTap, bool isOpen, {String? icon, int iconSize=16, String? title, bool isBorder=true} ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      if(title != null)...{

        Padding(
          padding: padding(horizontal: 6),
          child: Text(
            title,
            style: style12Regular().copyWith(color: greyA5),
          ),
        ),

        space(8),
      },

      Container(
        width: getSize().width,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(),
          border: isBorder
            ? Border.all(
                color: greyE7,
                width: 1
              )
            : null
        ),

        child: Column(
          children: [

            
            GestureDetector(
              onTap: (){
                onTapOpenBox();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: padding(horizontal: 20),
                height: 52,
                width: getSize().width,
                child: Row(
                  children: [

                    if(icon != null)...{
                      SvgPicture.asset(
                        icon,
                        width: iconSize.toDouble(),
                      ),

                      space(0,width: 11),
                    },

                    Text(
                      itemSelected.isEmpty ? hint : itemSelected,
                      style: style14Regular().copyWith(color: greyB2),
                    ),


                    const Spacer(),

                    Icon(
                      !isOpen ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                      color: greyE7,
                    )
                    
                  ],
                ),
              )
            ),

            AnimatedCrossFade(
              firstChild: Container(
                width: getSize().width,
                constraints: BoxConstraints(
                  maxHeight: getSize().height * .5,
                  minHeight: 0,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                      ...List.generate(items.length, (index) {
                        
                        return GestureDetector(
                          onTap: (){
                            onTap(items[index], index);
                            onTapOpenBox();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: padding(horizontal: 16),
                            width: getSize().width,
                            height: 35,
                            child: Text(
                              items[index],
                              style: style14Regular(),
                            ),
                          ),
                        );
                      })
                
                    ],
                  ),
                ),
              ), 
              secondChild: SizedBox(width: getSize().width), 
              crossFadeState: isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
              duration: const Duration(milliseconds: 300)
            ),

          ],
        ),
      ),
    ],
  );
}

RatingBar ratingBar(String rate,{int itemSize=12,Function(double)? onRatingUpdate}){
  return RatingBar(
    ignoreGestures: onRatingUpdate == null,
    itemPadding: padding(horizontal: 0),  
    
    itemSize: itemSize.toDouble(),
    initialRating: double.parse(rate).round().toDouble(),
    ratingWidget: RatingWidget(
      full: SvgPicture.asset(AppAssets.starYellowSvg), 
      half: SvgPicture.asset(AppAssets.starYellowSvg), 
      empty: SvgPicture.asset(AppAssets.starGreySvg)
    ), 
    onRatingUpdate: (value) {
      if(onRatingUpdate != null){
        onRatingUpdate(value);
      }
    },
    glow: false,
  );
}


Widget faqDropDown(String title,String desc,bool isOpen,String icon,Function onTap){
  return Container(
    width: getSize().width,
    padding: padding(horizontal: 12,vertical: 12),
    margin: const EdgeInsets.only(bottom: 16),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: borderRadius(radius: 15),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: (){
            onTap();
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [

              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: green77(),
                  borderRadius: borderRadius(radius: 8)
                ),
                alignment: Alignment.center,

                child: SvgPicture.asset(AppAssets.questionSvg),
              ),

              space(0,width: 8),

              Expanded(
                child: Text(
                  title,
                  style: style14Bold(),
                )
              ),

              space(0,width: 12),

              Icon(
                isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                color: greyA5,
              )

            ],
          ),
        ),

        AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              desc,
              style: style14Regular().copyWith(color: greyA5),
            ),
          ), 
          secondChild: SizedBox(width: getSize().width),
          crossFadeState: isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
          duration: const Duration(milliseconds: 300)
        ),

      ],
    ),
  );


}


Widget commentUi(Comments comment,Function onTapOption){
  return Container(
    key: comment.globalKey,
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

            userProfile(comment.user  ?? UserModel()),

            GestureDetector(
              onTap: (){
                onTapOption();  
              },
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 45,
                height: 45,
                child: Icon(Icons.more_horiz,size: 30,color: greyA5,),
              ),
            )

          ],
        ),

        space(16),

        Text(
          comment.comment ?? '',
          style: style14Regular().copyWith(color: greyA5,height: 1.5),
        ),

        space(16),
        
        Text(
          timeStampToDate((comment.createAt ?? 0) * 1000),
          style: style14Regular().copyWith(color: greyA5,height: 1.5),
        ),


        // Replies
        if(comment.replies?.isNotEmpty ?? false)...{
          
          space(16),

          ...List.generate(comment.replies?.length ?? 0, (i) {
            return Container(
              width: getSize().width,
              padding: padding(horizontal: 16,vertical: 16),
              margin: const EdgeInsets.only(bottom: 14),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius(),
                border: Border.all(
                  color: greyE7
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // user info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      userProfile(comment.replies![i].user!),

                      GestureDetector(
                        onTap: (){
                          onTapOption();  
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Icon(Icons.more_horiz,size: 30,color: greyA5,),
                        ),
                      )

                    ],
                  ),

                  space(16),

                  Text(
                    comment.replies![i].comment ?? '',
                    style: style14Regular().copyWith(color: greyA5,height: 1.5),
                  ),

                  space(14),
                  
                  Text(
                    timeStampToDate((comment.replies![i].createAt ?? 0) * 1000),
                    style: style12Regular().copyWith(color: greyA5,height: 1.5),
                  ),
                ],
              ),

            );
          }),

        },

      ],
    ),
  );
            
}



Widget dashboardInfoBox(Color color, String icon, String title, String subTitle, Function onTap, {double width=140, double height=170, int icWidth=22}){
  return GestureDetector(
    onTap: (){

    },
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: width,
      height: height,
      padding: padding(horizontal: 20,vertical: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius(),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // circle icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(.5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,

            child: SvgPicture.asset(icon,colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: icWidth.toDouble()),
          ),

          const Spacer(),
          const Spacer(),

          Text(
            title,
            style: style20Bold(),
          ),
          
          space(4),

          Text(
            subTitle,
            style: style12Regular().copyWith(color: greyB2),
          ),

        ],
      ),
    ),
  );
}


Widget forumQuestionItem(Forums question,Function changeState,{ bool ignoreOnTap=false, bool isShowDownload=false, bool isShowAnswerCount=true, bool isShowMoreIcon=true,Function? getData}){
  

  return Stack(
    clipBehavior: Clip.none,
    children: [

      // details box
      GestureDetector(
        onTap: (){
          if(!ignoreOnTap){
            nextRoute(ForumAnswerPage.pageName, arguments: question);
          }
        },
        child: Container(
          width: getSize().width,
          margin: const EdgeInsets.only(bottom: 16),
          padding: padding(horizontal: 16, vertical: 16),
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius()
          ),
      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              // userInfo and answers count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  // userInfo
                  Row(
                    children: [
                      
                      ClipRRect(
                        borderRadius: borderRadius(radius: 100),
                        child: fadeInImage(question.user?.avatar ?? '', 40, 40)
                      ),
      
                      space(0, width: 8),
      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          Text(
                            question.user?.fullName ?? '',
                            style: style14Regular(),
                          ),
      
                          space(4),
                          
                          Text(
                            timeStampToDateHour((question.createdAt ?? 0) * 1000),
                            style: style12Regular().copyWith(color: greyA5),
                          ),
      
                        ],
                      )
      
                    ],
                  ),
      
                  // answer count or more buttom
                  if((question.can?.pin ?? false) && isShowMoreIcon)...{
      
                    GestureDetector(
                      onTap: () async {
                        LearningWidget.forumOptionSheet(
                          question.can!,question.pin!, 
                          (){
                            question.pin = !(question.pin ?? true);
        
                            changeState();
                          },
                          () async {
                            // bool? res = await LearningWidget.forumReplaySheet(question);

                            // if(res != null && res){
                            //   getData!();
                            // }
                          }, 
                          (){

                          }
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        height: 40,
                        child: Icon(Icons.more_horiz, color: greyB2,size: 30,),
                      ),
                    )
                    
                  }else...{
      
                    Container(
                      padding: padding(horizontal: 5,vertical: 4),
                      decoration: BoxDecoration(
                        color: greyF8,
                        borderRadius: borderRadius()
                      ),
      
                      child: Text(
                        '${question.answersCount ?? 0} ${appText.answers}',
                        style: style10Regular().copyWith(color: greyB2),
                      ),
                    )
                  }
                ],
              ),
      
              space(16),
      
              if(question.resolved ?? false)...{
                
                // Resolved
                Center(
                  child: Container(
                    padding: padding(horizontal: 4,vertical: 4),
                    
                    decoration: BoxDecoration(
                      color: green77(),
                      borderRadius: borderRadius(radius: 50),
                    ),
      
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
      
                        SvgPicture.asset(
                          AppAssets.checkCircleSvg,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          width: 20,
                        ),
      
                        space(0, width: 4),
      
                        Text(
                          appText.resolved,
                          style: style14Regular().copyWith(color: Colors.white),
                        ),
      
                        space(0, width: 4),
                      ],
                    ),
                  ),
                ),
      
                space(12),
              },
      
              Text(
                question.title ?? '',
                style: style16Bold(),
              ),
              
              space(12),
      
              
              Text(
                question.description ?? '',
                style: style14Regular().copyWith(color: greyA5),
              ),
              
              if(isShowAnswerCount)...{
                if(question.activeUsers?.isNotEmpty ?? false)...{
                  
                  space(12),
        
                  Container(
                    padding: padding(horizontal: 8, vertical: 8),
                    width: getSize().width,
                    decoration: BoxDecoration(
                      color: greyF8,
                      borderRadius: borderRadius(radius: 15)
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        // users image
                        Row(
                          children: [
        
                            
                            SizedBox(
                              width: (((((question.activeUsers?.length ?? 0) > 3) ? 3 : (question.activeUsers?.length ?? 0)) - 1) * 17) + 34,
                              height: 35,
                              child: Stack(
                                children: List.generate( ((question.activeUsers?.length ?? 0) > 3) ? 3 : (question.activeUsers?.length ?? 0) , (i) {
                                  return PositionedDirectional(
                                    start: i == 0 ? 0 : i * 17,
                                    child: ClipRRect(
                                      borderRadius: borderRadius(radius: 50),
                                      child: fadeInImage(question.activeUsers?[i] ?? '', 34, 34)
                                    )
                                  );
                                }),
                              ),
                            ),
        
                            space(0, width: 6),
        
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
        
                                Text(
                                  question.activeUsers?.length.toString() ?? '',
                                  style: style12Bold(),
                                ),
        
                                Text(
                                  appText.activeUsers,
                                  style: style10Regular().copyWith(color: greyA5),
                                ),
        
                              ],
                            )
                            
                          ],
                        ),
        
        
                        // line
                        Container(
                          width: 1,
                          height: 35,
                          color: greyE7,
                        ),
        
        
                        // last activity
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
        
                            Text(
                              timeStampToDateHour((question.lastActivity ?? 0) * 1000),
                              style: style12Bold(),
                            ),
        
                            Text(
                              appText.lastActivity,
                              style: style10Regular().copyWith(color: greyA5),
                            ),
        
                          ],
                        ),
        
        
                        space(0,width: 5)
                        
                      ],
                    ),
        
                  ) 
                }
              },

              if(isShowDownload && question.attachment != null)...{

                space(16),
                
                GestureDetector(
                  onTap: (){

                    if(!question.isDownload){
                      DownloadManager.download(question.attachment!, (progress) {
                        
                        if(progress <= 90){
                          if(!question.isDownload){
                            question.isDownload = true;
                            changeState();
                          }
                        }else{
                          question.isDownload = false;
                          changeState();
                        }

                      });
                    }
                  },
                  child: Container(
                    width: getSize().width,
                    padding: padding(horizontal: 12,vertical: 12),

                    decoration: BoxDecoration(
                      color: greyF8,
                      borderRadius: borderRadius(radius: 15)
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // details
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.downloadSvg),

                            space(0,width: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  appText.download,
                                  style: style12Bold(),
                                ),

                                space(2),

                                Text(
                                  question.attachment?.split('/').last ?? '',
                                  style: style12Regular().copyWith(color: greyA5),
                                )
                              ],
                            ),
                          ],
                        ),
                      
                        question.isDownload
                        ? loading()
                        : const SizedBox()
                      ],
                    ),

                  ),
                )
              }
      
            ],
          ),
        ),
      ),


      if(question.pin ?? false)...{
        PositionedDirectional(
          top: -12,
          end: 18,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: yellow29,
              shape: BoxShape.circle
            ),

            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssets.bookmarkSvg),
          )
        )
      }
    ],
  );
}

Widget forumAnswerItem(ForumAnswerModel answer,Function changeState,{Function? getNewData}){
  return Stack(
    clipBehavior: Clip.none,
    children: [

      // details box
      Container(
        width: getSize().width,
        margin: const EdgeInsets.only(bottom: 16),
        padding: padding(horizontal: 16, vertical: 16),
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius()
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // userInfo and answers count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                // userInfo
                userProfile(answer.user!),

                // answer count or more buttom
                GestureDetector(
                  onTap: () async {
                    LearningWidget.forumOptionSheet(
                      answer.can!,answer.pin!, 
                      (){
                        answer.pin = !(answer.pin ?? true);
                        ForumService.answerPin(answer.id!);

                        changeState();
                      },
                      (){
                        answer.resolved = !(answer.resolved ?? true);
                        ForumService.answerResolve(answer.id!);

                        changeState();
                      },
                      () async {
                       
                        bool? res = await LearningWidget.forumReplaySheet(null, isEdit: true, answer: answer);

                        if(res != null && res){
                          getNewData!();
                        }
                      }
                    );

                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    height: 40,
                    child: Icon(Icons.more_horiz, color: greyB2,size: 30,),
                  ),
                )
              

              ],
            ),

            space(16),

            Text(
              answer.description ?? '',
              style: style14Regular().copyWith(color: greyA5),
            ),

            space(12),

            Divider(color: grey3A.withOpacity(.15),thickness: .3),
            
            space(4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [

                // date
                Row(
                  children: [

                    SvgPicture.asset(AppAssets.calendarSvg, width: 8,),

                    space(0,width: 5),

                    Text(
                      timeStampToDateHour((answer.createdAt ?? 0) * 1000),
                      style: style12Regular().copyWith(color: greyA5),
                    ),

                  ],
                ),


                if(answer.resolved ?? false)...{
                
                  // Resolved
                  Container(
                    padding: padding(horizontal: 4,vertical: 4),
                    
                    decoration: BoxDecoration(
                      color: green77(),
                      borderRadius: borderRadius(radius: 50),
                    ),
        
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
        
                        SvgPicture.asset(
                          AppAssets.checkCircleSvg,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          width: 20,
                        ),
        
                        space(0, width: 4),
        
                        Text(
                          appText.resolved,
                          style: style14Regular().copyWith(color: Colors.white),
                        ),
        
                        space(0, width: 4),
                      ],
                    ),
                  ),
        
                },

              ],
            )
          ],
        ),
      ),


      if(answer.pin ?? false)...{
        PositionedDirectional(
          top: -12,
          end: 18,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: yellow29,
              shape: BoxShape.circle
            ),

            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssets.bookmarkSvg),
          )
        )
      }
    ],
  );
}

Widget helperBox(String icon, String title, String subTitle, {int iconSize = 20, int horizontalPadding = 21}){
  return Container(
    width: getSize().width,
    padding: padding(vertical: 9, horizontal: 9),
    margin: padding(horizontal: horizontalPadding.toDouble()),

    decoration: BoxDecoration(
      border: Border.all(
        color: greyE7
      ),
      borderRadius: borderRadius()
    ),

    child: Row(
      children: [

        // icon
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: green77(),
            shape: BoxShape.circle
          ),
          
          alignment: Alignment.center,
          child: SvgPicture.asset(icon, width: iconSize.toDouble(),),
        ),

        space(0,width: 10),

        // title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: style14Bold(),
              ),
              
              Text(
                subTitle,
                style: style12Regular().copyWith(color: greyB2),
              ),

            ],
          )
        ),

      ],
    ),
  );
}


Future downloadSheet(String downloadUrl, String name,{bool isOpen=true}) async {
  

  double progress = 0;
  CancelToken cancelToken = CancelToken();

  bool isStartDownload = false;
  

  return await baseBottomSheet(
    child: StatefulBuilder(
      builder: (context,state) {

        if(!isStartDownload){
          
          isStartDownload = true;

          DownloadManager.download(
            downloadUrl, 
            (va) {
              progress = va / 100;
              state((){});
            },
            name: name,
            cancelToken: cancelToken,
            
            onLoadAtLocal: (){
              if(context.mounted){
                backRoute();
              }
            },

            isOpen: isOpen

          );
        }
        
        return Padding(
          padding: padding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              space(20),

              Text(
                appText.download,
                style: style16Bold(),  
              ),

              space(25),

              Text(
                '${(progress * 100).toInt()} %',
                style: style14Regular(),  
              ),

              space(6),

              LinearProgressIndicator(
                backgroundColor: green77().withOpacity(.2),
                value: progress,
                valueColor: AlwaysStoppedAnimation<Color>(green77()),
              ),

              space(40),

              button(
                onTap: () async {
                  cancelToken.cancel();

                  await Future.delayed(const Duration(milliseconds: 600));

                  if(context.mounted){
                    backRoute();
                  }
                }, 
                width: getSize().width, 
                height: 52, 
                text: appText.cancel, 
                bgColor: green77(), 
                textColor: Colors.white
              ),

              space(30),
            ],
          ),
        );
          
        
      }
    )
  );

}