
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/list_quiz_model.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';

import '../../../../common/badges.dart';
import '../../../../common/common.dart';
import '../../../../config/assets.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';
import '../../../models/quize_model.dart';

class QuizzesWidget{

  static Widget item(Quiz data, Function onTap, {bool isMyResult=true, String? userGrade, String? status, bool isShowQuestionCount=false, bool isShowStatus=true, bool isShowQuizTime=false}){  
    
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: getSize().width,
        height: 100,
        padding: padding(horizontal: 8,vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius()
        ),

        child: Row(
          children: [
          
            Stack(
              children: [
                ClipRRect(
                  borderRadius: borderRadius(radius: 15),
                  child: fadeInImage(data.webinar?.image ?? '', 130, 100),
                ),


                if(isShowStatus)...{
                  PositionedDirectional(
                    top: 6,
                    start: 6,
                    child: status == 'passed'
                    ? Badges.passed()
                    : status == 'waiting'
                      ? Badges.waiting()
                      : status == 'failed'
                        ? Badges.failed()
                        : const SizedBox(),
                  )
                },

              ],
            ),

            space(0, width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  space(4),
            
                  Text(
                    data.title ?? '',
                    style: style14Bold(),
                  ),

                  const Spacer(flex: 1),
                  
                  Text(
                    data.webinar?.title ?? '',
                    style: style10Regular().copyWith(color: greyA5),
                    maxLines: 1,
                  ),

                  const Spacer(flex: 3),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // date
                      Row(
                        children: [
                          SvgPicture.asset( isShowQuizTime ? AppAssets.timeCircleSvg : AppAssets.calendarSvg, width: 12,),
                          
                          space(0,width: 4),

                          if(isShowQuizTime)...{

                            Text(
                              '${data.time} ${appText.min}',
                              style: style10Regular().copyWith(color: greyA5), 
                            )
                          }else...{

                            Text(
                              timeStampToDate((data.webinar?.createdAt ?? 0) * 1000),
                              style: style10Regular().copyWith(color: greyA5), 
                            )
                          }

                        ],
                      ),

                      if(isMyResult)...{
                        // Grade
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.badgeSvg, 
                              colorFilter: ColorFilter.mode(
                                status == 'passed'
                                ? green77()
                                : status == 'waiting'
                                  ? yellow29
                                  : status == 'failed'
                                    ? red49
                                    : yellow29, 
                                BlendMode.srcIn
                              ),
                              width: 9,
                            ),
                            
                            space(0,width: 4),

                            Text(
                              '$userGrade',
                              style: style12Regular().copyWith(
                                color: status == 'passed'
                                  ? green77()
                                  : status == 'waiting'
                                    ? yellow29
                                    : status == 'failed'
                                      ? red49
                                      : yellow29,
                              ), 
                            ),
                            
                            space(0,width: 12),

                          ],
                        ),

                      },


                      if(isShowQuestionCount)...{
                        // question count
                        Row(
                          children: [

                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greyB2
                              ),
                              alignment: Alignment.center,
                              
                              child: SvgPicture.asset(
                                AppAssets.questionSvg, 
                                colorFilter: const ColorFilter.mode(
                                  Colors.white, 
                                  BlendMode.srcIn
                                ),
                                height: 6,
                              ),
                            ),
                            
                            space(0,width: 5),

                            Text(
                              data.questioncount?.toString() ?? '',
                              style: style12Regular().copyWith(color: greyA5), 
                            ),
                            

                          ],
                        ),

                        space(0,width: 12),
                      }


          
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
  
  
  static Widget listItem(ListQuizModel data, Function onTap){  
    
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius()
        ),
      
        width: getSize().width,
        height: 100,
        padding: padding(horizontal: 12,vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        
        child: Row(
          children: [
            
            ClipRRect(
              borderRadius: borderRadius(radius: 15),
              child: fadeInImage(data.webinar?.thumbnail ?? '', 130, 100),
            ),
        
            space(0, width: 12),
        
            Expanded(
              child: Container(
                width: getSize().width,
                height: 100,
                margin: const EdgeInsets.only(bottom: 16),
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius()
                ),
              
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    space(4),
                    
                    Text(
                      data.getTitle(),
                      style: style14Bold(),
                      maxLines: 1,
                    ),
                
                    const Spacer(flex: 1),
                    
                    Text(
                      data.webinar?.getTitle() ?? '',
                      style: style10Regular().copyWith(color: greyA5), 
                    ),
                    
                    const Spacer(flex: 4),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                
                        // date
                        Row(
                          children: [
                            SvgPicture.asset( AppAssets.timeCircleSvg, width: 12,),
                            
                            space(0,width: 4),
                
                            Text(
                              '${data.time} ${appText.min}',
                              style: style10Regular().copyWith(color: greyA5), 
                            )
                           
                          ],
                        ),
                
                
                        Row(
                          children: [
                          
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greyB2
                              ),
                              alignment: Alignment.center,
                              
                              child: SvgPicture.asset(
                                AppAssets.questionSvg, 
                                colorFilter: const ColorFilter.mode(
                                  Colors.white, 
                                  BlendMode.srcIn
                                ),
                                height: 6,
                              ),
                            ),
                            
                            space(0,width: 5),
                          
                            Text(
                              data.questionCount?.toString() ?? '-',
                              style: style12Regular().copyWith(color: greyA5), 
                            ),
                            
                            space(0,width: 12),
                          
                          ],
                        ),
                          
                        
                          
                
                          
                      ],
                    ),
                
                    space(4),
                  ],
                ),
              
              ),
            ),
          ],
        ),
      ),
    );

  }

  
}