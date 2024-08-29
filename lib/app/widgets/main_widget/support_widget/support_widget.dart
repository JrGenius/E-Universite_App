import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webinar/app/models/purchase_course_model.dart';
import 'package:webinar/app/services/user_service/support_service.dart';
import 'package:webinar/app/services/user_service/user_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/config/colors.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;

import '../../../../common/components.dart';
import '../../../../common/utils/app_text.dart';
import '../../../../config/assets.dart';
import '../../../../config/styles.dart';

class SupportWidget{

  static Future<bool?> newSupportMessageSheet() async {

    TextEditingController titleController = TextEditingController();
    FocusNode titleNode = FocusNode();

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();


    bool isOpenDepartments = false;

    // ignore: unused_local_variable
    int? departmentId;

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
                      appText.newSupportMessage,
                      style: style16Bold(),
                    ),

                    space(16),

                    input(titleController, titleNode, appText.title, isBorder: true,iconPathLeft: AppAssets.profileSvg),

                    space(12),

                    FutureBuilder(
                      future: SupportService.getDepartments(),
                      builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.done || snapshot.hasData){

                          return dropDown(
                            appText.selectDepartment, 
                            snapshot.data?.singleWhere((element) => element['id'] == departmentId, orElse: ()=> {})['title'] ?? '', 
                            List.generate(snapshot.data?.length ?? 0, (index) => snapshot.data?[index]['title']), 
                            (){
                              isOpenDepartments = !isOpenDepartments;
                              state((){});
                            }, 
                            (newValue, index) {
                              departmentId = snapshot.data?[index]['id'];

                              state((){});
                            }, 
                            isOpenDepartments,
                            icon: AppAssets.ticketSvg
                          );
                        }

                        return loading();

                      },
                    ),

                    space(12),

                    descriptionInput(descController, descNode, appText.description, isBorder: true,),

                    space(16),

                    Center(
                      child: button(
                        onTap: () async {

                          if(titleController.text.trim().isNotEmpty && descController.text.trim().isNotEmpty && departmentId != null){
                          
                            state((){
                              isLoading = true;
                            });
                            
                            
                            bool res = await SupportService.createMessage(
                              titleController.text.trim(), 
                              descController.text.trim(), 
                              departmentId, 
                              null, // courseId
                              attachment
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
  

  static Future newSupportMessageForClassesSheet() async {

    TextEditingController titleController = TextEditingController();
    FocusNode titleNode = FocusNode();

    TextEditingController descController = TextEditingController();
    FocusNode descNode = FocusNode();


    bool isOpenDepartments = false;

    // ignore: unused_local_variable
    int? webinarId;

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
                      appText.newSupportMessage,
                      style: style16Bold(),
                    ),

                    space(16),

                    input(titleController, titleNode, appText.title, isBorder: true,iconPathLeft: AppAssets.profileSvg),

                    space(12),

                    FutureBuilder(
                      future: UserService.getPurchaseCourse(),
                      builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.done || snapshot.hasData){

                          return dropDown(
                            appText.classes, 
                            snapshot.data?.singleWhere((element) => element.id == webinarId, orElse: ()=> PurchaseCourseModel()).webinar?.title ?? '', 
                            List.generate(snapshot.data?.length ?? 0, (index) => snapshot.data?[index].webinar?.title ?? ''), 
                            (){
                              isOpenDepartments = !isOpenDepartments;
                              state((){});
                            }, 
                            (newValue, index) {
                              webinarId = snapshot.data?[index].id;

                              state((){});
                            }, 
                            isOpenDepartments,
                            icon: AppAssets.ticketSvg
                          );
                        }

                        return loading();

                      },
                    ),

                    space(12),

                    descriptionInput(descController, descNode, appText.description, isBorder: true,),

                    space(16),

                    Row(
                      children: [

                        button(
                          onTap: () async {

                            final imagePicker.ImagePicker picker = imagePicker.ImagePicker();
                            final imagePicker.XFile? image = await picker.pickImage(source: imagePicker.ImageSource.gallery);


                            if(image != null){
                              Directory appDocDir = await getApplicationDocumentsDirectory();
                              String address = '${appDocDir.path}/${DateTime.now().millisecond}.jpg';

                              var result = await FlutterImageCompress.compressAndGetFile(
                                File(image.path).path, 
                                address,
                                quality: 75,
                                minWidth: 700,
                              );

                              attachment = File(result!.path);
                             
                            }

                            
                          }, 
                          width: 52,
                          height: 52,
                          text: '', 
                          bgColor: Colors.white, 
                          textColor: green77(),
                          iconPath: AppAssets.attachmentSvg,
                          borderColor: green77()
                        ),
                        
                        space(0,width: 16),

                        Expanded(
                          child: button(
                            onTap: () async {

                              if(titleController.text.trim().isNotEmpty && descController.text.trim().isNotEmpty && webinarId != null){
                              
                                state((){
                                  isLoading = true;
                                });
                                
                                
                                bool res = await SupportService.createMessage(
                                  titleController.text.trim(), 
                                  descController.text.trim(), 
                                  null, // departmentId
                                  webinarId,
                                  attachment
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
                          )
                        ),

                      ],
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