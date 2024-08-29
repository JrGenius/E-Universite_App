import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/services/user_service/comments_service.dart';
import 'package:webinar/common/badges.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../common/common.dart';
import '../../../../common/components.dart';

import '../../../../common/utils/app_text.dart';
import '../../../models/blog_model.dart';

class CommentsWidget{
  
  
  static Widget myCommnetsItem(Comments data,Function onTap,{bool isSmallSize=true,double height=85,double bottomMargin=16,bool ignoreTap=false}){
  
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: bottomMargin),
    
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius()
      ),
    
      padding: padding(horizontal: 8,vertical: 8),
      width: getSize().width,
    
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
    
            // image
            ClipRRect(
              borderRadius: borderRadius(radius: 14),
              child: Stack(
                children: [
    
                  fadeInImage(
                    data.webinar?.image ?? '', 
                    135, 
                    height
                  ),
    
                  // rate and notification and progress
                  PositionedDirectional(
                    start: 5,
                    top: 5,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                        )
                      ),
    
                      child: data.status == 'pending' ? Badges.pending() : const SizedBox(),
                    ),
                  )
    
    
    
                  
                ],  
              ),
            ),
    
            // details
            Expanded(
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: padding(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                                      
                      // title
                      Text(
                        data.webinar?.title ?? '',
                        style: style14Bold().copyWith(height: 1.3),
                        maxLines: 2,
                      ),

                      space(8),
                      
                      // name and date and time
                      ratingBar(data.webinar?.rate ?? '0'),
                  
                      const Spacer(),

                      Row(
                        children: [

                          SvgPicture.asset(AppAssets.calendarSvg),

                          space(0,width: 4),

                          Text(
                            timeStampToDateHour((data.createAt ?? 0) * 1000),
                            style: style10Regular().copyWith(color: greyA5),
                          )
                        ],
                      )

                  
                    ],
                  ),
                ),
              ),
            ),
    
    
            
    
          ],
        ),
      ),
    );

  }

  

  static showReplayDialog(int id){
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();


    bool isLoading = false;
    
    
    return baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.replyToComment,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    descriptionInput(messageController, messageNode, appText.description, isBorder: true,),
              
                    space(20),

                    Center(
                      child: button(
                        onTap: () async {
                          if(messageController.text.trim().isNotEmpty){
                            
                            isLoading = true;
                            state((){});
                    
                            bool res = await CommentsService.instructorReplay(id, messageController.text.trim());
                    
                            isLoading = false;
                            state((){});
                    
                            if(res){
                              backRoute();
                            }
                            
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.reply,
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }

  static showReportDialog(int id){
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();


    bool isLoading = false;
    
    
    return baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.reportComment,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    descriptionInput(messageController, messageNode, appText.messageToReviewer, isBorder: true,),
              
                    space(20),

                    Center(
                      child: button(
                        onTap: () async {
                          if(messageController.text.trim().isNotEmpty){
                            
                            isLoading = true;
                            state((){});
                    
                            bool res = await CommentsService.report(id, messageController.text.trim());
                    
                            isLoading = false;
                            state((){});
                    
                            if(res){
                              backRoute();
                            }
                            
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.report,
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }

  static showEditDialog(int id, String message) async {
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();

    messageController.text = message;

    bool isLoading = false;
    
    
    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 21,
                  left: 21
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    space(25),
              
                    Text(
                      appText.editComment,
                      style: style20Bold(),
                    ),
              
                    space(20),

                    descriptionInput(messageController, messageNode, appText.description, isBorder: true,),
              
                    space(20),

                    Center(
                      child: button(
                        onTap: () async {
                          if(messageController.text.trim().isNotEmpty){
                            
                            isLoading = true;
                            state((){});
                    
                            bool res = await CommentsService.update(id, messageController.text.trim());
                    
                            isLoading = false;
                            state((){});
                    
                            if(res){
                              backRoute(arguments: messageController.text);
                            }
                            
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.save,
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    space(20),
              
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }


}