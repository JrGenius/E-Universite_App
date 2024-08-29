import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/services/user_service/blog_service.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../models/basic_model.dart';

class BlogWidget{

  static showOptionDialog(int postId,int? commentId,bool isLogin, {String itemName = 'blog'}){
    return baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            space(25),
      
            Text(
              appText.commentOptions,
              style: style20Bold(),
            ),
      
            space(16),
      
            if(isLogin)...{
              GestureDetector(
                onTap: (){
                  backRoute();
                  showReplayDialog(postId, commentId, itemName: itemName);
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
        
                    SvgPicture.asset(AppAssets.replaySvg),
        
                    space(0,width: 8),
        
                    Text(
                      appText.reply,
                      style: style16Regular(),
                    ),
        
                  ],
                ),
              ),
              
              space(20),
            },
      
            GestureDetector(
              onTap: (){
                backRoute();
                showReportDialog(commentId!);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
      
                  SvgPicture.asset(AppAssets.reportSvg),
      
                  space(0,width: 8),
      
                  Text(
                    appText.report,
                    style: style16Regular(),
                  ),
      
                ],
              ),
            ),

            space(52),
      
          ],
        ),
      )
    );
  }

  static Future<bool?> showReplayDialog(int postId,int? commentId,{String itemName='blog'}) async {
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();
    
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
                      commentId == null
                      ? appText.comments
                      : appText.replyToComment,
                      style: style20Bold(),
                    ),
              
                    space(20),
              
                    descriptionInput(messageController, messageNode, appText.description,isBorder: true,),
              
                    space(20),
              
                    Center(
                      child: button(
                        onTap: () async {
                          if(messageController.text.trim().isNotEmpty){
                            isLoading = true;
                            state((){});
                                    
                            bool res = await BlogService.saveComments(
                              postId, commentId, 
                              itemName, messageController.text.trim()
                            );
                                    
                            isLoading = false;
                            state((){});
                                    
                            backRoute(arguments: res);
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.submitComment,
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


  static showReportDialog(int commentId){
    
    TextEditingController messageController = TextEditingController();
    FocusNode messageNode = FocusNode();
    
    
    return baseBottomSheet(
      child: Builder(
        builder: (context) {
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
                  appText.messageToReviewer,
                  style: style20Bold(),
                ),
          
                space(20),

                descriptionInput(messageController, messageNode, appText.description,isBorder: true,),
          
                space(20),

                button(
                  onTap: (){
                    if(messageController.text.trim().isNotEmpty){
                      BlogService.reportComments(
                        commentId,
                        messageController.text.trim()
                      );

                      backRoute();
                    }
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.report,
                  bgColor: green77(), 
                  textColor: Colors.white
                ),

                space(20),
          
              ],
            ),
          );
        }
      )
    );
  }

  static Future showCategoriesDialog(BasicModel? selectedCategory, List<BasicModel> categories) async {
    
    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
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
                  appText.blogCategories,
                  style: style20Bold(),
                ),
          
                space(20),
                
                ...List.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      backRoute(arguments: categories[index]);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      height: 45,
                      child: Text(
                        categories[index].title ?? '',
                        style: style16Regular().copyWith(color: categories[index].id == selectedCategory?.id ? green77() : grey3A),
                      ),
                    ),
                  );
                }),

                space(20),

          
              ],
            ),
          );
        }
      )
    );
  }


}