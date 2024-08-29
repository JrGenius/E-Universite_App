import 'package:flutter/material.dart';
import 'package:webinar/app/models/assignment_model.dart';
import 'package:webinar/app/pages/main_page/home_page/assignments_page/assignment_history_page.dart';
import 'package:webinar/app/services/user_service/assignment_service.dart';
import 'package:webinar/app/widgets/main_widget/assignment_widget/submissions_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';

class SubmissionsPage extends StatefulWidget {
  static const String pageName = '/submissions';
  const SubmissionsPage({super.key});

  @override
  State<SubmissionsPage> createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> with SingleTickerProviderStateMixin{

  late TabController tabController;

  List<AssignmentModel> allSubmissionData = [];
  List<AssignmentModel> pendingData = [];

  bool isLoadingPending = false;

  int? assignmentId;
  
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      assignmentId = ModalRoute.of(context)!.settings.arguments as int?;

      if(assignmentId != null){
        getData();
      }
    });
  }


  getData(){

    setState(() {
      isLoadingPending = true;
    });

    pendingData.clear();
    allSubmissionData.clear();

    AssignmentService.getStudents(assignmentId!).then((value) {
      
      for (var i = 0; i < value.length; i++) {
        if(value[i].userStatus == 'pending'){
          pendingData.add(value[i]);
        }
      }

      setState(() {
        allSubmissionData = value;
        isLoadingPending = false;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.submissions),

        body: Column(
          children: [
            
            tabBar(
              (p0) => null, 
              tabController, 
              [
                Tab(
                  text: appText.pending,
                  height: 32,
                ),
                
                Tab(
                  text: appText.allSubmissions,
                  height: 32,
                ),

              ]
            ),


            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  
                  isLoadingPending
                ? loading()
                : pendingData.isEmpty
                  ? emptyState(AppAssets.submissionEmptyStateSvg, appText.noSubmissions, appText.noSubmissionsDesc)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(vertical: 20),
                      child: Column(
                        children: List.generate(pendingData.length, (index) {
                          return SubmissionsWidget.userItem(
                            (){
                              nextRoute(AssignmentHistoryPage.pageName, arguments: [pendingData[index], true ]);
                            },
                            pendingData[index]
                          );
                        }),
                      ),
                    ),

                  
                  isLoadingPending
                ? loading()
                : allSubmissionData.isEmpty
                  ? emptyState(AppAssets.submissionEmptyStateSvg, appText.noSubmissions, appText.noSubmissionsDesc)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(vertical: 20),
                      child: Column(
                        children: List.generate(allSubmissionData.length, (index) {
                          return SubmissionsWidget.userItem(
                            () async {
                              await nextRoute(AssignmentHistoryPage.pageName, arguments: [allSubmissionData[index], true ]);

                              getData();
                            }, 
                            allSubmissionData[index]
                          );
                        }),
                      ),
                    ),

                ]
              )
            )
          ],
        ),
      )
    );
  }
}