import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/assignment_model.dart';
import 'package:webinar/common/badges.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../pages/main_page/home_page/assignments_page/assignment_overview_page.dart';

class AssignmentWidget{

  static Widget assignmentItem(AssignmentModel assignment, {bool froUserRole=true}){
    return GestureDetector(
      onTap: (){
        nextRoute(AssignmentOverviewPage.pageName, arguments: [assignment, froUserRole]);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding(horizontal: 8,vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        width: getSize().width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(),
        ),

        child: Column(
          children: [
            

            // image and title
            Row(
              children: [
                
                // image
                SizedBox( 
                  width: 130,
                  height: 85,

                  child: Stack(
                    children: [

                      ClipRRect(
                        borderRadius: borderRadius(radius: 15),
                        child: fadeInImage(assignment.webinarImage ?? '', 130, 85)
                      ),

                      if(froUserRole)...{
                        PositionedDirectional(
                          start: 5,
                          top: 5,
                          child: assignment.userStatus == 'passed'
                            ? Badges.passed()
                            : assignment.userStatus == 'not_submitted'
                              ? Badges.notSubmitted()
                              : assignment.userStatus == 'not_passed'
                                ? Badges.failed()
                                : Badges.pending()
                        ),
                      }else...{
                        PositionedDirectional(
                          start: 5,
                          top: 5,
                          child: assignment.status == 'passed'
                            ? Badges.passed()
                            : Badges.active()
                        ),
                      }

                    ],
                  ),
                ),

                space(0,width: 10),

                // details
                Expanded(
                  child: SizedBox(
                    height: 75,
                    width: getSize().width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                
                        Text(
                          assignment.title ?? '',
                          style: style14Bold(),
                        ),
                        
                        Text(
                          assignment.webinarTitle ?? '',
                          style: style12Regular().copyWith(color: greyA5),
                        ),
                        
                        if(froUserRole)...{
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.plusSvg),
                  
                              Text( 
                                '  ${assignment.usedAttemptsCount}/${assignment.attempts} ${appText.attempts}',
                                style: style12Regular().copyWith(color: greyA5),
                              ),
                  
                            ],
                          )
                        }else...{
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.more2Svg),
                  
                              Text( 
                                '  ${assignment.pendingCount} ${appText.pending}',
                                style: style12Regular().copyWith(color: greyA5),
                              ),
                  
                            ],
                          )
                        }
                
                      ],
                    ),
                  ),
                )

              ],
            ),

            space(18),            

            Row(
              children: [

                // deadline
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        froUserRole ? appText.deadline : appText.totalSubmissions,
                        style: style12Regular().copyWith(color: greyA5),
                      ),
                      
                      space(5),
                      
                      Text(
                        froUserRole ? timeStampToDateHour((assignment.deadlineTime ?? 0) * 1000) : assignment.submissionsCount.toString(),
                        style: style14Regular().copyWith(),
                      ),
                
                    ],
                  ),
                ),
                
                // grade or last submission
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        froUserRole 
                          ? assignment.userStatus == 'passed' ? appText.grade : appText.lastSubmission
                          : appText.averageGrade,
                        style: style12Regular().copyWith(color: greyA5),
                      ),
                      
                      space(5),
                      
                      Text(
                        froUserRole
                          ? assignment.userStatus == 'passed' ? '${assignment.passGrade}/${assignment.totalGrade}' : assignment.lastSubmission == null ? '-' : timeStampToDateHour(assignment.lastSubmission! * 1000)
                          : assignment.avgGrade.toString(),
                        style: style14Regular().copyWith(),
                      ),
                
                
                    ],
                  ),
                ),

              ],
            )


          ],
        ),

      ),
    );
  }
}