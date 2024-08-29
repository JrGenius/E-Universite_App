import 'package:flutter/material.dart';
import 'package:webinar/app/models/assignment_model.dart';
import 'package:webinar/app/services/user_service/assignment_service.dart';
import 'package:webinar/app/widgets/main_widget/assignment_widget/assignment_history_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/enums/error_enum.dart';
import 'package:webinar/common/utils/app_text.dart';

import '../../../../../config/colors.dart';
import '../../../../models/chat_model.dart';

class AssignmentHistoryPage extends StatefulWidget {
  static const String pageName = '/assignment-history';
  const AssignmentHistoryPage({super.key});

  @override
  State<AssignmentHistoryPage> createState() => _AssignmentHistoryPageState();
}

class _AssignmentHistoryPageState extends State<AssignmentHistoryPage> {

  List<ChatModel> historyData = [];
  bool isLoading = true;
  bool isInstructor = false;

  late AssignmentModel assignment;

  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      assignment = (ModalRoute.of(context)!.settings.arguments as List)[0] as AssignmentModel;
      isInstructor = (ModalRoute.of(context)!.settings.arguments as List)[1];

      print(assignment.id);
      
      getData(
        assignment.id!, // assignment id
        assignment.student!.id! // student id
      );
      
      if(!isInstructor){
        if(assignment.userStatus == 'passed'){
          showSnackBar(ErrorEnum.success, appText.assignmentPassed, desc: appText.assignmentPassedDesc);
        }else if(assignment.userStatus == 'not_passed'){
          showSnackBar(ErrorEnum.error, appText.assignmentClosed, desc: appText.assignmentPassedDesc);
        }
      }
      
      setState(() {});

    });

  }

  getData(int assignmentId, int studentId) async {

    setState(() {
      isLoading = true;
    });

    historyData = await AssignmentService.getHistory(assignmentId, studentId);

    setState(() {
      isLoading = false;
    });

    goBottom();

  }

  goBottom(){
    Future.delayed(const Duration(seconds: 1)).then((value) {
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.assignmentHistory),

        body: isLoading
        ? loading()
        : Stack(
            children: [

              // chats
              Positioned.fill(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: padding(),
                  
                  child: Column(
                    children: [

                      space(20),

                      ...List.generate(historyData.length, (index) {
                        return AssignmentHistoryWidget.message(historyData[index]);
                      }),

                      space(150),

                    ],
                  ),

                )
              ),

              if((assignment.userStatus != 'passed' && assignment.userStatus != 'not_passed') || isInstructor)...{

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
                    child: Row(
                      children: [

                        Expanded(
                          child: button(
                            onTap: () async {
                        
                              bool? res = await AssignmentHistoryWidget.newReplaySheet(assignment.id!,assignment.student!.id!);

                              if(res != null && res){
                                getData(assignment.id!, assignment.student!.id!);
                              }
                            },
                            width: getSize().width, 
                            height: 52, 
                            text: appText.reply, 
                            bgColor: Colors.white, 
                            textColor: green77(),
                            borderColor: green77(),
                            raduis: 15
                          ),
                        ),

                        if(isInstructor)...{
                          space(0, width: 20),

                          Expanded(
                            child: button(
                              onTap: () async {
                                bool? res = await AssignmentHistoryWidget.setGradeSheet(assignment.id!, assignment.passGrade!.toString());

                                if(res != null && res){
                                  getData(assignment.id!, assignment.student!.id!);
                                }
                              },
                              width: getSize().width, 
                              height: 52, 
                              text: appText.rateAssignment, 
                              bgColor: green77(), 
                              textColor: Colors.white,
                              raduis: 15
                            ),
                          ),
                        }

                        
                      ],
                    ),
                  )
                ),
              
              }

            ],
          ),
      )
    );
  }
}