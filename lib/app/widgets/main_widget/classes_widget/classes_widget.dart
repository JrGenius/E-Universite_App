import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/common/badges.dart';
import 'package:webinar/common/utils/date_formater.dart';

import '../../../../common/common.dart';
import '../../../../common/components.dart';
import '../../../../common/utils/app_text.dart';
import '../../../../common/utils/currency_utils.dart';
import '../../../../config/assets.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../pages/main_page/home_page/single_course_page/single_course_page.dart';

class ClassessWidget{

  
  
  
  
  static Widget classesItem(CourseModel courseData, {bool showProgress=true,Function? onTap, bool expired=false, int? expiredDate}){

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 16),
    
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
      ),
    
      padding: padding(horizontal: 10,vertical: 9),
      width: getSize().width,
    
      child: GestureDetector(
        onTap: (){
          if(onTap == null){
            nextRoute(SingleCoursePage.pageName, arguments: [courseData.id, courseData.type == 'bundle']);
          }else{
            onTap();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // course details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
    
                // image
                ClipRRect(
                  borderRadius: borderRadius(radius: 15),
                  child: fadeInImage(
                    courseData.image ?? '', 
                    130, 
                    85
                  ),
                ),
    
                // details
                Expanded(
                  child: SizedBox(
                    height: 85,
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
                          
                          
                          // name and date and time
                          Row(
                            children: [
                              ratingBar(courseData.rate ?? '0'),

                              if(courseData.isPrivate == 1)...{
                                space(0,width: 6),

                                Badges.private()
                              }
                            ],
                          ),
                      
                          // price and date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              // date
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  SvgPicture.asset(AppAssets.timeSvg,colorFilter:  ColorFilter.mode(greyA5, BlendMode.srcIn),),
                                  
                                  space(0,width: 4),
                  
                                  Text(
                                    '${formatHHMMSS(courseData.duration ?? 0)} ${appText.hours}',
                                    style: style10Regular().copyWith(color: greyB2),
                                  ),
                                  
                                ],
                              ),

                              // price
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
    
    
    
                              
                            ],
                          ),

                      
                        ],
                      ),
                    ),
                  ),
                ),
    
    
                
    
              ],
            ),

            space(18),

            // category and publish date
            Row(
              children: [

                // category
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        appText.category,
                        style: style12Regular().copyWith(color: greyA5),
                      ),

                      space(6),
                                                      
                      Text(
                        courseData.category ?? '',
                        style: style14Regular(),
                      ),

                    ],
                  )
                ),
               
                // Publish Date
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        appText.publishDate,
                        style: style12Regular().copyWith(color: greyA5),
                      ),

                      space(6),
                                                      
                      Text(
                        timeStampToDate((courseData.createdAt ?? 0) * 1000),
                        style: style14Regular(),
                      ),

                    ],
                  )
                ),


              ],
            ),

            if(showProgress)...{
              space(18),

              // progress
              SizedBox(
                width: getSize().width,
                // padding: padding(horizontal: 8,vertical: 8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth,
                      height: 8,
                      // padding: padding(horizontal: 1.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius(),
                        border: Border.all(
                          color: greyE7
                        )
                      ),
                      alignment: AlignmentDirectional.centerStart,
                        
                      child: Container(
                        width: constraints.maxWidth * ( (courseData.progressPercent ?? 0) / 100 ),
                        height: 6,
                        decoration: BoxDecoration(
                          color: green77(),
                          borderRadius: borderRadius()
                        ),
                      ),
                    );
                  },
                ),
              )
            },

            if(expired)...{
              space(10),

              Container(
                width: getSize().width,
                padding: padding(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: red49.withOpacity(.1),
                  borderRadius: borderRadius(radius: 100),
                ),

                child: Row(
                  children: [

                    SvgPicture.asset(AppAssets.calendarEmptySvg, width: 15, colorFilter: ColorFilter.mode(red49, BlendMode.srcIn)),

                    space(0,width: 6),

                    Text(
                      '${appText.accessExpiresOn} ${timeStampToDate((expiredDate ?? 0) * 1000)}',
                      style: style14Regular().copyWith(color: red49,height: 1.4),
                    )
                  ],
                ),
              )
            },

            space(12),
          ],
        ),
      ),
    );
  }
}