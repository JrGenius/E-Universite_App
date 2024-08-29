import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/instructor_assignment_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/assignment_service.dart';
import 'package:webinar/app/widgets/main_widget/assignment_widget/assignment_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../models/assignment_model.dart';

class AssignmentsPage extends StatefulWidget {
  static const String pageName = '/assignments';
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> with SingleTickerProviderStateMixin{



  late TabController tabController;


  List<AssignmentModel> myAssignments = [];
  InstructorAssignmentModel? studentAssignments;

  bool isLoadingMyAssignment = false;
  bool isLoadingStudentAssignment = false;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: locator<UserProvider>().profile?.roleName == 'user' ? 1 : 2, vsync: this);

    getData();
  }

  getData(){

    setState(() {
      isLoadingMyAssignment = true;
      isLoadingStudentAssignment = false;
    });


    AssignmentService.getAssignments().then((value) {

      myAssignments = value;
      
      setState(() {
        isLoadingMyAssignment = false;
      });
    });
    
    AssignmentService.getAllAssignmentsInstructor().then((value) {

      studentAssignments = value;

      setState(() {
        isLoadingStudentAssignment = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    // AppData.getAccessToken().then((value) {
    //   print(value);
    // });
    
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.assignments),

        body: Column(
          children: [

            tabBar(
              (p0) {
              
              }, 
              tabController, 
              [
                Tab(
                  text: appText.myAssignments,
                  height: 32,
                ),
                
                if(locator<UserProvider>().profile?.roleName != 'user')...{
                  Tab(
                    text: appText.studentAssignmetns,
                    height: 32,
                  ),
                }
              ]
            ),


            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  
                  isLoadingMyAssignment
                  ? loading()
                  : SingleChildScrollView( // my assignments
                      physics: const BouncingScrollPhysics(),
                      padding: padding(vertical: 20),
                      child: Column(
                        children: List.generate(myAssignments.length, (index) {
                          return AssignmentWidget.assignmentItem(myAssignments[index]);
                        }),
                      ),
                    ),
                  
                  if(locator<UserProvider>().profile?.roleName != 'user')...{ // student assignments
                    isLoadingStudentAssignment
                    ? loading()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: padding(vertical: 20),
                        child: Column(
                          children: [
                            
                            // 3 item
                            Container(
                              width: getSize().width,
                              padding: padding(horizontal: 4,vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: borderRadius(),
                                border: Border.all(color: greyE7)
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  // pending
                                  Column(
                                    children: [

                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: yellow29.withOpacity(.3),
                                          shape: BoxShape.circle
                                        ),
                                        alignment: Alignment.center,

                                        child: SvgPicture.asset(AppAssets.more2Svg,colorFilter:  ColorFilter.mode(yellow29, BlendMode.srcIn), width: 20,),
                                      ),

                                      space(8),

                                      Text(
                                        studentAssignments?.pendingReviewsCount?.toString() ?? '-',
                                        style: style14Bold(),
                                      ),

                                      space(4),

                                      Text(
                                        appText.pending,
                                        style: style12Regular().copyWith(color: greyB2),
                                      ),

                                    ],
                                  ),

                                  // Passed
                                  Column(
                                    children: [

                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: green50.withOpacity(.3),
                                          shape: BoxShape.circle
                                        ),
                                        alignment: Alignment.center,

                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: green50,
                                            borderRadius: borderRadius(radius: 5)
                                          ),
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(AppAssets.checkSvg, colorFilter:  ColorFilter.mode(Colors.white.withOpacity(.6), BlendMode.srcIn), width: 10,)
                                        ),
                                      ),

                                      space(8),

                                      Text(
                                        studentAssignments?.passedCount?.toString() ?? '-',
                                        style: style14Bold(),
                                      ),

                                      space(4),

                                      Text(
                                        appText.passed,
                                        style: style12Regular().copyWith(color: greyB2),
                                      ),

                                    ],
                                  ),

                                  // failed
                                  Column(
                                    children: [

                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: red49.withOpacity(.3),
                                          shape: BoxShape.circle
                                        ),
                                        alignment: Alignment.center,

                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: red49,
                                            borderRadius: borderRadius(radius: 5)
                                          ),
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(AppAssets.clearSvg, colorFilter:  ColorFilter.mode(Colors.white.withOpacity(.6), BlendMode.srcIn), width: 9,)
                                        ),
                                      ),

                                      space(8),

                                      Text(
                                        studentAssignments?.failedCount?.toString() ?? '-',
                                        style: style14Bold(),
                                      ),

                                      space(4),

                                      Text(
                                        appText.failed,
                                        style: style12Regular().copyWith(color: greyB2),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            
                            space(16),

                            ...List.generate(studentAssignments?.assignments?.length ?? 0, (index) {
                              return AssignmentWidget.assignmentItem(studentAssignments!.assignments![index], froUserRole: false);
                            }),  
                          ],
                        ),
                    )
                  }

                ]
              )
            )
            
          ],
        ),

      )
    );
  }
}