import 'package:flutter/material.dart';
import 'package:webinar/app/models/forum_answer_model.dart';
import 'package:webinar/app/models/forum_model.dart';
import 'package:webinar/app/services/user_service/forum_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';

import '../../../../../../config/colors.dart';
import '../../../../../widgets/main_widget/home_widget/single_course_widget/learning_widget.dart';

class ForumAnswerPage extends StatefulWidget {
  static const String pageName = '/answers-question';
  const ForumAnswerPage({super.key});

  @override
  State<ForumAnswerPage> createState() => _ForumAnswerPageState();
}

class _ForumAnswerPageState extends State<ForumAnswerPage> {

  Forums? questionData;
  List<ForumAnswerModel> answers = [];

  bool isLoading = false;
  
 
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      questionData = ModalRoute.of(context)!.settings.arguments as Forums;

      getData();
    });
  }

  getData() async {

    setState(() {
      isLoading = true;
    });

    answers = await ForumService.getAnswers(questionData!.id!);

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(
          title: questionData?.title ?? ''
        ),

        body: isLoading
      ? loading()
      : Stack(
          children: [

            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),
                
                child: Column(
                  children: [
          
                    space(16),
                    
                    if(questionData != null)...{
                      forumQuestionItem(
                        questionData!,
                        (){
                          setState(() {});
                        },
                        ignoreOnTap: true,
                        isShowAnswerCount: false,
                        isShowMoreIcon: false,
                        isShowDownload: true
                      )
                    },
          
                    ...List.generate(answers.length, (index) {
                      return forumAnswerItem(
                        answers[index], 
                        (){
                          setState(() {});
                        },
                        getNewData: getData
                      );
                    }),

                    space(120),
          
                  ],
                ),
              ),
            ),

            // replay button
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
                  onTap: () async {
                    bool? res = await LearningWidget.forumReplaySheet(questionData!);

                    if(res != null && res){
                      getData();
                    }
                  }, 
                  width: 52, 
                  height: 52, 
                  text: appText.reply, 
                  bgColor: green77(), 
                  textColor: Colors.white,
                )
              )
            ),

          ],
        ),
      )
    );
  }
}