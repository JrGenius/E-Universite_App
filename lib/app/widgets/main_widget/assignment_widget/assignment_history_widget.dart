import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/services/user_service/assignment_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import '../../../models/chat_model.dart';

class AssignmentHistoryWidget{
  

  static Widget message(ChatModel data){
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: getSize().width,

      child: Column(
        crossAxisAlignment: data.sender == null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          // icon and title
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              
              if(data.sender != null)...{
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [boxShadow(Colors.black.withOpacity(.11), blur: 15, y: 10)]
                  ),

                  child: ClipRRect(
                    borderRadius: borderRadius(radius: 48),
                    child: fadeInImage(data.sender?.avatar ?? '', 48, 48)
                  ),
                ),
              },

              // message
              Expanded(
                child: Container(
                  width: getSize().width,
                  alignment: data.sender == null ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,

                  child: Container(
                    padding: padding(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: data.sender == null ? green77() : greyE7,

                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: const Radius.circular(20),
                        topStart: const Radius.circular(20),
                        bottomEnd: Radius.circular(data.sender == null ? 0 : 20),
                        bottomStart: Radius.circular(data.sender == null ? 20 : 0)
                      )
                    ),

                    child: Text(
                      data.message ?? '',
                      style: style14Regular().copyWith(color: data.sender != null ? greyA5 : Colors.white),
                    ),
                  ),
                )
              )

            ],
          ),


          // date
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: data.sender == null ? 0 : 60,
              top: 8 
            ),
            child: Text(
              timeStampToDate((data.createdAt ?? 0) * 1000),
              style: style12Regular().copyWith(color: greyA5),
            ),
          ),

          // file
          if(data.filePath != null)...{

            Container(
              margin: EdgeInsetsDirectional.only(
                top: 12,
                start: data.sender == null ? 0 : 60
              ),
              width: getSize().width,
              alignment: data.sender == null ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
              
              child: GestureDetector(
                onTap: (){
                  downloadSheet(data.filePath!, data.filePath!.split('/').last);
                },
                child: Container(
                  padding: padding(horizontal: 14,vertical: 12),
                  constraints: BoxConstraints(
                    minWidth: getSize().width * .1,
                    maxWidth: getSize().width * .7
                  ),
              
                  decoration: BoxDecoration(
                    color: greyF8,
                    borderRadius: borderRadius(),
                    border: Border.all(color: greyE7)
                  ),
              
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
              
                      SvgPicture.asset(AppAssets.attachmentSvg, colorFilter: ColorFilter.mode(greyA5, BlendMode.srcIn), width: 15),
              
                      space(0,width: 6),
              
                      Text(
                        data.fileTitle ?? '',
                        style: style12Regular().copyWith(color: greyA5),
                      )
              
                      
                    ],
                  ),
                ),
              ),
            ),

          }

        ],
      ),
    );
  }



  static Future newReplaySheet(int assignmentId, int studentId) async {

    // TextEditingController titleController = TextEditingController();
    // FocusNode titleNode = FocusNode();

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();

    // ignore: unused_local_variable
    File? attachment;
    bool isLoading = false;

    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: StatefulBuilder(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),
          
                    Text(
                      appText.assignmentSubmission,
                      style: style16Bold(),
                    ),

                    space(16),

                    // input(titleController, titleNode, appText.fileTileOptional, isBorder: true,iconPathLeft: AppAssets.profileSvg),

                    // space(12),

                    descriptionInput(descController, descNode, appText.description, isBorder: true,),

                    space(16),

                    Center(
                      child: button(
                        onTap: () async {
                      
                          if(descController.text.trim().isNotEmpty){
                            state((){
                              isLoading = true;
                            });
                            
                            bool res = await AssignmentService.newQuestion(
                              assignmentId, 
                              '', 
                              descController.text.trim(), 
                              attachment,
                              studentId
                            );
                      
                            if(res){
                              backRoute(arguments: true);
                            }
                      
                            state((){
                              isLoading = false;
                            });
                          }
                      
                        }, 
                        width: getSize().width,
                        height: 52,
                        text: appText.send, 
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    // Row(
                    //   children: [

                    //     // button(
                    //     //   onTap: () async {

                    //     //     final imagePicker.ImagePicker picker = imagePicker.ImagePicker();
                    //     //     final imagePicker.XFile? image = await picker.pickImage(source: imagePicker.ImageSource.gallery);


                    //     //     if(image != null){
                    //     //       Directory appDocDir = await getApplicationDocumentsDirectory();
                    //     //       String address = '${appDocDir.path}/${DateTime.now().millisecond}.jpg';

                    //     //       var result = await FlutterImageCompress.compressAndGetFile(
                    //     //         File(image.path).path, 
                    //     //         address,
                    //     //         quality: 75,
                    //     //         minWidth: 700,
                    //     //       );

                    //     //       attachment = File(result!.path);
                             
                    //     //     }

                            
                    //     //   }, 
                    //     //   width: 52,
                    //     //   height: 52,
                    //     //   text: '', 
                    //     //   bgColor: Colors.white, 
                    //     //   textColor: green77(),
                    //     //   iconPath: AppAssets.attachmentSvg,
                    //     //   borderColor: green77()
                    //     // ),
                        
                    //     // space(0,width: 16),

                        
                    //   ],
                    // ),

                    space(28),

          
                  ],
                );
              }
            ),
          );
        },
      )
    );
  }
  


  static Future setGradeSheet(int historyId, String grade) async {

    TextEditingController titleController = TextEditingController();
    FocusNode titleNode = FocusNode();

    bool isLoading = false;

    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: StatefulBuilder(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),
          
                    Text(
                      appText.assignmentSubmission,
                      style: style16Bold(),
                    ),
                    
                    space(10),
                    
                    Text(
                      '${appText.passGradeIis} $grade',
                      style: style12Regular().copyWith(color: greyA5),
                    ),

                    space(20),

                    input(titleController, titleNode, appText.grade, isBorder: true,iconPathLeft: AppAssets.starSvg, isNumber: true),

                    space(12),


                    Center(
                      child: button(
                        onTap: () async {
                    
                          if(titleController.text.trim().isNotEmpty){
                            state((){
                              isLoading = true;
                            });
                            
                            bool res = await AssignmentService.setGrade(
                              historyId, 
                              int.parse(titleController.text.trim()),
                            );
                    
                            if(res){
                              backRoute(arguments: true);
                            }
                    
                            state((){
                              isLoading = false;
                            });
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

                    space(28),

          
                  ],
                );
              }
            ),
          );
        },
      )
    );
  }
  
}