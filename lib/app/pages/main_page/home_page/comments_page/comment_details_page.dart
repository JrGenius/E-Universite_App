import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/app/services/user_service/comments_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../widgets/main_widget/comments_widget/comments_widget.dart';

class CommentDetailsPage extends StatefulWidget {
  static const String pageName = '/comment-details';
  const CommentDetailsPage({super.key});

  @override
  State<CommentDetailsPage> createState() => _CommentDetailsPageState();
}

class _CommentDetailsPageState extends State<CommentDetailsPage> {

  Comments? comment;
  bool isUser=true;

  bool isDeleting = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      comment = (ModalRoute.of(context)!.settings.arguments as List)[0];
      isUser = (ModalRoute.of(context)!.settings.arguments as List)[1];

      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.commentDetails),

        body: comment == null
      ? const SizedBox()
      : Stack(
          children: [

            // details
            Positioned.fill(
              child: Padding(
                padding: padding(),
                child: Column(
                  children: [
              
                    space(20),

                    if(isUser)...{

                      Container(
                        width: getSize().width,
                        padding: padding(horizontal: 10, vertical: 10),

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyE7,
                          ),
                          borderRadius: borderRadius()
                        ),

                        child: Row(
                          children: [

                            // video
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: green77(),
                                shape: BoxShape.circle
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(AppAssets.videoSvg),
                            ),

                            space(0, width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            
                                  Text(
                                    appText.thisCommentIsFor,
                                    style: style12Regular().copyWith(color: greyB2),
                                  ),
                            
                                  space(4),
                                  
                                  Text(
                                    comment?.webinar?.title ?? '',
                                    style: style14Bold(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            
                                ],
                              ),
                            )

                          ],
                        ),

                      ),

                      space(16),
                    },
              
                    userProfile(comment!.user!),
              
                    space(16),
              
                    SizedBox(
                      width: getSize().width,
                      child: Text(
                        comment?.comment ?? '',
                        style: style14Regular().copyWith(color: greyA5),
                      ),
                    ),
              
                  ],
                ),
              )
            ),



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
                child: isUser
              ? Row(
                  children: [

                    Expanded(
                      child: button(
                        onTap: () async {
                          String? res = await CommentsWidget.showEditDialog(comment!.id!, comment!.comment!);

                          if(res != null){
                            comment!.comment = res;
                            setState(() {});
                          }
                        },
                        width: getSize().width, 
                        height: 52, 
                        text: appText.edit, 
                        bgColor: green77(), 
                        textColor: Colors.white,
                        raduis: 15
                      ),
                    ),

                    space(0, width: 20),

                    Expanded(
                      child: button(
                        onTap: () async {
                          
                          setState(() {
                            isDeleting = true;
                          });

                          bool res = await CommentsService.delete(comment!.id!);

                          setState(() {
                            isDeleting = false;
                          });

                          if(res){
                            backRoute();
                          }

                        },
                        width: getSize().width, 
                        height: 52, 
                        text: appText.delete, 
                        bgColor: red49, 
                        textColor: Colors.white,
                        raduis: 15,
                        isLoading: isDeleting
                      ),
                    ),
                    
                  ],
                )
              : Row(
                  children: [

                    Expanded(
                      child: button(
                        onTap: () async {
                          CommentsWidget.showReplayDialog(comment!.id!);
                        },
                        width: getSize().width, 
                        height: 52, 
                        text: appText.reply, 
                        bgColor: green77(), 
                        textColor: Colors.white,
                        raduis: 15
                      ),
                    ),

                    space(0, width: 20),

                    Expanded(
                      child: button(
                        onTap: () async {
                          CommentsWidget.showReportDialog(comment!.id!);           
                        },
                        width: getSize().width, 
                        height: 52, 
                        text: appText.report, 
                        bgColor: Colors.white, 
                        textColor: green77(),
                        borderColor: green77(),
                        raduis: 15
                      ),
                    ),
                    
                  ],
                ),
              )
            ),
              

          ],

        ),

      )
    );
  }
}