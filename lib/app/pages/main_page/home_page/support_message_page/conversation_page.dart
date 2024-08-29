import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/support_model.dart';
import 'package:webinar/app/services/user_service/support_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/utils/app_text.dart';
import '../../../../../config/assets.dart';
import '../../../../../config/colors.dart';
import '../../../../widgets/main_widget/assignment_widget/assignment_history_widget.dart';

class ConversationPage extends StatefulWidget {
  static const String pageName = '/conversation';
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  int? id;

  SupportModel? data;
  bool isLoading = false;
  bool isLoadingSendMessage = false;

  ScrollController scrollController = ScrollController();
  File? attachment;


  TextEditingController messageController = TextEditingController();
  FocusNode messageNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      id = ModalRoute.of(context)!.settings.arguments as int;

      getData();
    });
  }

  getData() async {

    setState(() {
      isLoading = true;
    });

    data = await SupportService.getOne(id!);

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

        appBar: appbar(title: data?.title ?? ''),

        body: isLoading
      ? loading()
      : Stack(
          children: [

            Positioned.fill(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: padding(),
            
                child: Column(
                  children: [
            
                    space(20),

                    if(data?.webinar != null)...{

                      Container(
                        width: getSize().width,
                        padding: padding(horizontal: 9,vertical: 9),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius(),
                          border: Border.all(
                            color: greyE7
                          )
                        ),

                        child: Row(
                          children: [

                            // icon
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: green77(),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(AppAssets.videoSvg),
                            ),

                            space(0,width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    appText.thisIsACourseSupportMessage,
                                    style: style12Regular().copyWith(color: greyB2),
                                  ),

                                  space(4),
                                  
                                  Text(
                                    data?.webinar?.title ?? '',
                                    style: style14Bold(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              )
                            )

                          ],
                        ),
                      ),

                      space(16),
                    },

                    ...List.generate(data?.conversations?.length ?? 0, (index) {
                      return AssignmentHistoryWidget.message(data!.conversations![index]);
                    }),

                    space(150)
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                width: getSize().width,

                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                  bottom: 30
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    boxShadow(Colors.black.withOpacity(.05), blur: 15, y: -3)
                  ],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
                ),

                child: Column(
                  children: [

                    // input
                    TextFormField(
                      controller: messageController,
                      focusNode: messageNode,

                      style: style16Regular(),

                      decoration: InputDecoration(

                        hintStyle: style14Regular().copyWith(color: greyA5),
                        labelStyle: style14Regular().copyWith(color: greyA5),
                        alignLabelWithHint: true,
                        labelText: appText.message,
                        contentPadding: padding(horizontal: 0,vertical: 10),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyE7,
                          )
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyE7,
                          )
                        ),
                        
                      ),
                    ),

                    space(16),

                    // buttons
                    Center(
                      child: button(
                        onTap: () async {
                      
                          if(messageController.text.trim().isNotEmpty){
                            
                            setState(() {
                              isLoadingSendMessage = true;
                            });
                            
                            bool res = await SupportService.sendMessage(
                              messageController.text.trim(), 
                              attachment, 
                              id!
                            );
                      
                            if(res){
                              messageController.clear();
                              attachment = null;
                              getData();
                            }
                            
                            setState(() {
                              isLoadingSendMessage = false;
                            });
                      
                          }
                      
                        }, 
                        width: getSize().width,
                        height: 52,
                        text: appText.send, 
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoadingSendMessage
                      ),
                    ),
                  ],
                )
              )
            )

          ],
        ),

      )
    );
  }
}