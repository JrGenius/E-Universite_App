import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:webinar/app/pages/main_page/home_page/assignments_page/submissions_page.dart';
import 'package:webinar/app/services/user_service/assignment_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../config/assets.dart';
import '../../../../models/assignment_model.dart';
import '../../../../widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';
import 'assignment_history_page.dart';

class AssignmentOverviewPage extends StatefulWidget {
  static const String pageName = '/assignment-overview';
  const AssignmentOverviewPage({super.key});

  @override
  State<AssignmentOverviewPage> createState() => _AssignmentOverviewPageState();
}

class _AssignmentOverviewPageState extends State<AssignmentOverviewPage> {

  AssignmentModel? assignment;
  bool isMyAssignment=true;

  List<AssignmentModel> students = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      assignment = (ModalRoute.of(context)!.settings.arguments as List)[0];
      isMyAssignment = (ModalRoute.of(context)!.settings.arguments as List)[1] ?? true;

      if(!isMyAssignment){
        getStudents();
      }

      setState(() {});
    });
  }


  getStudents() async {

    students = await AssignmentService.getStudents(assignment!.id!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        
        appBar: appbar(title: appText.assignmentOverview),

        body: Stack(
          children: [

            // details
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                
            
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    Padding(
                      padding: padding(),
                      child: Column(
                        children: [
                          space(16),
                    
                          Text(
                            assignment?.title ?? '',
                            style: style16Bold(),
                          ),
                    
                          space(6),
                    
                          Text(
                            assignment?.title ?? '',
                            style: style12Regular().copyWith(color: greyB2),
                          ),
                    
                    
                          space(25),
                    
                          // image
                          Padding(
                            padding: padding(),
                            child: AspectRatio(
                              aspectRatio: 16 / 10,
                              child: ClipRRect(
                                borderRadius: borderRadius(),
                                child: fadeInImage(assignment?.webinarImage ?? '', getSize().width, getSize().width)
                              ),
                            ),
                          ),
                    
                          space(30),
                    
                          // assignment Details
                          Center(
                            child: Text(
                              appText.assignmentDetails,
                              style: style20Bold(),
                            ),
                          ),
                    
                          space(10),
                    
                          // description
                          Container(
                            margin: padding(),
                            width: getSize().width,
                            padding: padding(horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: greyE7),
                              borderRadius: borderRadius()
                            ),
                    
                            child: Text(
                              assignment?.description ?? '',
                              style: style14Regular().copyWith(color: greyA5),
                            ),
                          ),
                    
                          space(30),
                    
                          // info
                          Container(
                            padding: padding(),
                            width: getSize().width,
                            child: Wrap(
                              runSpacing: 20,
                              children: [
                    
                                if(isMyAssignment)...{ // 1
                                  SingleCourseWidget.courseStatus(
                                    appText.deadline, 
                                    (assignment?.deadline?.toString() ?? '').isNumeric() ? '${assignment?.deadline?.toString() ?? ''} ${appText.day}' : assignment?.deadline?.toString() ?? '', 
                                    AppAssets.infoSquareSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                    
                                }else...{
                                  
                                  SingleCourseWidget.courseStatus(
                                    appText.submissions, 
                                    assignment?.submissionsCount?.toString() ?? '0', 
                                    AppAssets.documentSvg,
                                    width:(getSize().width * .5) - 42,
                                  ),
                                },
                                
                                if(isMyAssignment)...{ // 2
                                  SingleCourseWidget.courseStatus(
                                    appText.attempts, 
                                    assignment?.attempts?.toString() ?? '-', 
                                    AppAssets.plusSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                    
                                }else...{
                                  
                                  SingleCourseWidget.courseStatus(
                                    appText.pending, 
                                    assignment?.pendingCount?.toString() ?? '0', 
                                    AppAssets.more2Svg,
                                    width:(getSize().width * .5) - 42,
                                  ),
                                },
                                
                                if(isMyAssignment)...{ // 3
                                  SingleCourseWidget.courseStatus(
                                    appText.firstSubmission, 
                                    timeStampToDateHour((assignment?.firstSubmission ?? 0) * 1000), 
                                    AppAssets.calendarSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                    
                                }else...{
                                  
                                  SingleCourseWidget.courseStatus(
                                    appText.passed, 
                                    assignment?.passedCount?.toString() ?? '0', 
                                    AppAssets.tickSquareSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                                },
                                
                                if(isMyAssignment)...{ // 4
                                  SingleCourseWidget.courseStatus(
                                    appText.lastSubmission, 
                                    timeStampToDateHour((assignment?.lastSubmission ?? 0) * 1000), 
                                    AppAssets.calendarSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                    
                                }else...{
                                  
                                  SingleCourseWidget.courseStatus(
                                    appText.failed, 
                                    assignment?.failedCount?.toString() ?? '0', 
                                    AppAssets.closeSquareSvg,
                                    width: (getSize().width * .5) - 42,
                                  ),
                                },
                                
                                
                                SingleCourseWidget.courseStatus( // 5
                                  appText.totalGrade, 
                                  assignment?.totalGrade?.toString() ?? '0', 
                                  AppAssets.starSvg,
                                  width: (getSize().width * .5) - 42,
                                ),
                                
                                SingleCourseWidget.courseStatus( // 6
                                  appText.passGrade, 
                                  assignment?.passGrade?.toString() ?? '0', 
                                  AppAssets.tickSquareSvg,
                                  width: (getSize().width * .5) - 42,
                                ),
                                
                                SingleCourseWidget.courseStatus( // 7
                                  isMyAssignment ? appText.yourGrade : appText.averageGrade, 
                                  isMyAssignment ? assignment?.grade?.toString() ?? '0' : assignment?.avgGrade?.toString() ?? '0', 
                                  AppAssets.chartSvg,
                                  width: (getSize().width * .5) - 42,
                                ),
                                
                                SingleCourseWidget.courseStatus( // 7
                                  appText.status, 
                                  isMyAssignment ? assignment?.userStatus?.toString() ?? '-' : assignment?.status?.toString() ?? '-', 
                                  AppAssets.chartSvg,
                                  width: (getSize().width * .5) - 42,
                                ),
                                
                    
                          
                              ],
                            ),
                          ),
                    
                          space(20),
                        ],
                      ),
                    ),
            
                    if(students.isNotEmpty)...{
                      // students
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Padding(
                            padding: padding(),
                            child: Text(
                              appText.latestSubmissions,
                              style: style16Bold(),
                            ),
                          ),
            
                          space(16),
            
                          SizedBox(
                            width: getSize().width,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: padding(),
                              scrollDirection: Axis.horizontal,
            
                              child: Row(
                                children: [
                                  ...List.generate(students.length, (index) {

                                    return Padding(
                                      padding: const EdgeInsetsDirectional.only(end:15),
                                      child: userProfile(
                                        students[index].student!,
                                        isBoldTitle: true, 
                                        isBackground: true,
                                        customSubtitle: timeStampToDate((students[index].purchaseDate ?? 0) * 1000),
                                        
                                        isBoxLimited: true,

                                      ),
                                    );
                                    
                                  })
                                ],
                              ),
            
                            ),
                          ),
            
                          space(16),
            
                        ],
                      ),
                    },
            
            
                    Padding(
                      padding: padding(),
                      child: Text(
                        appText.attachments,
                        style: style16Bold(),
                      ),
                    ),
            
                    space(16),
            
                    SizedBox(
                      width: getSize().width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: padding(),
                        scrollDirection: Axis.horizontal,
            
                        child: Row(
                          children: List.generate(assignment?.attachments?.length ?? 0, (index) {
                            return horizontalChapterItem(
                              greyF8, 
                              AppAssets.paperDownloadSvg, 
                              assignment?.attachments?[index].title ?? '', 
                              assignment?.attachments?[index].size ?? '', 
                              (){
                                downloadSheet(assignment!.attachments![index].url!, assignment!.attachments![index].url!.split('/').last);
                              },
                              iconColor: greyB2
                            );
                          }),
                        ),
                      ),
                    ),
            
            
                    space(150),
                    
            
                  ],
                ),
              
              ),
            ),

            // button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
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
                  onTap: (){

                    if(isMyAssignment){
                      nextRoute(AssignmentHistoryPage.pageName, arguments: [assignment!, false ]);
                    }else{
                      nextRoute(SubmissionsPage.pageName, arguments: assignment!.id);
                    }
                    
                  },
                  width: getSize().width, 
                  height: 52, 
                  text: isMyAssignment ? appText.viewAssignment : appText.reviewSubmissions, 
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