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

class SubmissionsWidget{
  

  static Widget userItem(Function onTap,AssignmentModel assignment){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: getSize().width,
        padding: padding(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(radius: 20),
        ),

        child: Row(
          children: [
            
            // image
            ClipRRect(
              borderRadius: borderRadius(radius: 15),
              child: fadeInImage(assignment.student?.avatar ?? '', 68, 68),
            ),

            space(0, width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Text(
                          assignment.student?.fullName ?? '',
                          style: style14Bold(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),


                      assignment.userStatus == 'not_passed'
                        ? Badges.failed()
                        : assignment.userStatus == 'not_submitted'
                          ? Badges.notSubmitted()
                          : assignment.userStatus == 'passed'
                            ? Badges.passed()
                            : Badges.pending()

                    ],
                  ),

                  // email
                  Text(
                    assignment.student?.email ?? '',
                    style: style12Regular().copyWith(color: greyA5),
                  ),

                  space(22),

                  // date and grade
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.calendarSvg),
                          
                          space(0,width: 6),

                          Text(
                            timeStampToDate((assignment.purchaseDate ?? 0) * 1000),
                            style: style10Regular().copyWith(color: greyB2),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          
                          SvgPicture.asset(
                            assignment.userStatus == 'not_submitted'|| assignment.userStatus == 'pending'
                            ? AppAssets.plusSvg
                            : AppAssets.badgeSvg,

                            colorFilter: ColorFilter.mode(
                              assignment.userStatus == 'not_submitted' || assignment.userStatus == 'pending'
                                ? greyB2
                                : assignment.userStatus == 'not_passed' 
                                  ? red49
                                  : green50, 
                              BlendMode.srcIn
                            ),
                            width: 10,
                          ),

                          space(0,width: 6),

                          Text(
                            assignment.userStatus == 'not_submitted' || assignment.userStatus == 'pending'
                              ? '${assignment.usedAttemptsCount}/${assignment.attempts} ${appText.attempts}'
                              : '${assignment.grade}/${assignment.totalGrade}',
                            style: style10Regular().copyWith(
                              color: assignment.userStatus == 'not_submitted' || assignment.userStatus == 'pending'
                                ? greyB2
                                : assignment.userStatus == 'not_passed' 
                                  ? red49
                                  : green50,
                            ),
                          )


                        ],
                      ),


                      const SizedBox(),
                      const SizedBox(),

                    ],
                  )

                ],
              )
            )

          ],
        ),
      ),
    );
  } 
}