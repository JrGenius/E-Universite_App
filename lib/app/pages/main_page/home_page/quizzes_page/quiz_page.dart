import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/quize_model.dart';
import 'package:webinar/app/services/user_service/quiz_service.dart';
import 'package:webinar/app/widgets/main_widget/quizzes_widget/quiz_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../config/assets.dart';
import '../../../../../locator.dart';
import '../../../../providers/user_provider.dart';

class QuizPage extends StatefulWidget {
  static const String pageName = '/quiz';
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<QuizModel> data = [];
  Quiz? quizData;
  
  QuizModel? reviewQuizData;

  int? quizResultId;
  int? quizId;

  int currentQuestionIndex=0;


  bool isLoadingGetQuizData = false;
  bool isStartQuiz = false;
  bool isLoadingSendingResult = false;
  bool isReview = false;



  late Timer timer;
  Duration? quizTime;
  int? seconds;
  int? minutes;

  double progressValue = 0;
  
  String beforTabPage = '';

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      if(((ModalRoute.of(context)!.settings.arguments as List)[0]) is QuizModel){
        reviewQuizData = (ModalRoute.of(context)!.settings.arguments as List)[0];
        quizData = reviewQuizData?.quiz;
        quizId = reviewQuizData?.id;
        isStartQuiz = true;

      }else if(((ModalRoute.of(context)!.settings.arguments as List)[0]) is Quiz){
        Quiz? data = (ModalRoute.of(context)!.settings.arguments as List)[0];
        quizId = data?.id;  
      }else{
        quizId = (ModalRoute.of(context)!.settings.arguments as List)[0];
      }

      try{
        isReview = (ModalRoute.of(context)!.settings.arguments as List)[1];
      }catch(_){}
      
      try{
        beforTabPage = (ModalRoute.of(context)!.settings.arguments as List)[2] ?? '';
      }catch(_){}

      if(!isReview){
        getData();
      }else{
        getQuizForReview();
      }

      setState(() {});
    });
    
  }

  getData() async {
    
    setState(() {
      isLoadingGetQuizData = true;
    });
    
    Map? res = await QuizService.startQuiz(quizId!);

    if(res != null){
      quizData = res['quiz'];
      quizResultId = res['quiz_result_id'];
      
      startTimer();
      isStartQuiz = true;
    }
    
    setState(() {
      isLoadingGetQuizData = false;
    });
  }


  getQuizForReview() async {

    setState(() {
      isLoadingGetQuizData = true;
    });

    reviewQuizData = await QuizService.reviewQuiz(quizId!, beforTabPage);

    quizData = reviewQuizData?.quiz;
    isStartQuiz = true;

    setState(() {
      isLoadingGetQuizData = false;
    });
  }


  startTimer(){

    quizTime = Duration(seconds: ((quizData?.time ?? 0) * 60));

    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 

      
      if((quizTime?.inSeconds ?? -1) >= 1){
        progressValue = ( (quizTime?.inSeconds ?? 0) / ((quizData?.time ?? 0) * 60) );
        

        quizTime = Duration(seconds: quizTime!.inSeconds - 1);
        seconds = int.parse(formatHHMMSS(quizTime?.inSeconds ?? 0).split(':').last);
        setState(() {});
      }else{
        print('........end........');
        timer.cancel();
      }
    });

  }

  bool isTeacher(){
    return (locator<UserProvider>().profile?.id ?? -1) == quizData?.teacher?.id;
  }
  
  @override
  void dispose() {
    try{
      timer.cancel();
    }catch(_){}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: green77(),
          elevation: 0,
          shadowColor: Colors.grey.withOpacity(.2),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: 80,

          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: padding(),
              child: Row(
                children: [
          
                  GestureDetector(
                    onTap: (){
                      backRoute();
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                        borderRadius: borderRadius()
                      ),
          
                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.backSvg, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                    ),
                  ),
          
                  space(0,width: 14),
          
                  Text(
                    quizData?.title ?? '',
                    style: style16Regular().copyWith(color: Colors.white),
                  )
            
                ],
              ),
            ),
          ),

        ),

        body: Stack(
          children: [

            // quiz details
            Positioned.fill(
              child: Column(
                children: [
            
                  // green box
                  SizedBox(
                    width: getSize().width,
                    child: AnimatedCrossFade(
            
                      firstChild: Container(
                        width: getSize().width,
                        height: 20,
                        decoration: BoxDecoration(
                          color: green77(),
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28))
                        ),
                      ), 
            
                      secondChild: Container(
                        decoration: BoxDecoration(
                          color: green77(),
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28))
                        ),
                        width: getSize().width,
                        height: 130,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                      
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                AppAssets.appbarLineSvg,
                                width: getSize().width * .9,
                              )
                            ),
                            
                            Positioned(
                              top: 0,
                              right: 21,
                              bottom: 0,
                              left: 21,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
            
                                  space(10),

                                  if(isReview)...{
                                    
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        space(0, width: getSize().width),

                                        Text(
                                          appText.quizReview,
                                          style: style20Bold().copyWith(color: Colors.white),
                                        ),

                                        space(8),
                                        
                                        Text(
                                          '${appText.thisQuizIncludes} ${quizData?.questions?.length ?? '0'} ${appText.questionsForReview}',
                                          style: style14Regular().copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),

                                    const Spacer(),

                                  }else...{
                                    // timer 
                                    QuizWidget.timer(progressValue, quizTime, seconds),
                                  },
                      
            
                                  // question and counter                
                                  QuizWidget.questionProgressBar(currentQuestionIndex, quizData),

                                  space(16),
            
                                ],
                              ),
                              
                            ),
                      
                          ],
                        ),
                      ), 
                 
                      crossFadeState: !isStartQuiz ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                      duration: const Duration(milliseconds: 300), 
            
                    ),
                  ),
            
            
                  // questions
                  Expanded(
                    child: isLoadingGetQuizData
                  ? loading()
                  : !isStartQuiz
                ? const SizedBox()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),
            
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
            
                        space(16, width: getSize().width),
          
                        // question title
                        Text(
                          (quizData?.questions?.isNotEmpty ?? false)
                            ? (quizData?.questions?[currentQuestionIndex].title ?? '')
                            : '',
                          style: style16Bold(),
                        ),
          
                        space(4),
          
                        Text(
                          (quizData?.questions?.isNotEmpty ?? false)
                            ? '${appText.grade}: ${quizData?.questions?[currentQuestionIndex].grade ?? 0}'
                            : '',
                          style: style12Regular().copyWith(color: greyA5),
                        ),
          
                        space(26),

                        if((quizData?.questions?.isNotEmpty ?? false))...{

                          if( quizData?.questions?[currentQuestionIndex].type == 'descriptive' )...{

                            descriptionInput(
                              isReview
                                ? (
                                    quizData!.questions![currentQuestionIndex].inputController..text = reviewQuizData?.answersheet?.items[
                                      reviewQuizData?.answersheet?.items.keys.toList().singleWhere((element) => quizData!.questions![currentQuestionIndex].id.toString() == element)
                                    ]?.answer?.toString() ?? '-'
                                  )
                                : quizData!.questions![currentQuestionIndex].inputController, 
                              quizData!.questions![currentQuestionIndex].node, appText.typeYourAnswerHere,
                              isBorder: true,

                              isReadOnly: isReview
                            ),

                            if(isReview && isTeacher())...{
                              space(20),

                              Text(
                                appText.correctAnswer,
                                style: style16Bold(),
                              ),
                              
                              space(10),

                              descriptionInput(
                                TextEditingController(
                                  text: quizData!.questions![currentQuestionIndex].descriptivecorrectanswer ?? ''
                                ),
                                  
                                quizData!.questions![currentQuestionIndex].node, appText.typeYourAnswerHere,
                                isBorder: true,

                                isReadOnly: true,
                              ),

                              space(16),

                              // Student Grade
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Text(
                                    appText.studentGrade,
                                    style: style16Bold(),
                                  ),


                                  Row(
                                    children: [
                                      
                                      // min
                                      GestureDetector(
                                        onTap: (){

                                          if(quizData!.questions![currentQuestionIndex].gradeForUser! > 1){
                                            setState(() {
                                              quizData!.questions![currentQuestionIndex].gradeForUser ??= 0; 
                                              quizData!.questions![currentQuestionIndex].gradeForUser = quizData!.questions![currentQuestionIndex].gradeForUser! - 1;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: padding(horizontal: 12, vertical: 18),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: borderRadius(radius: 12),
                                            boxShadow: [boxShadow(Colors.black.withOpacity(.05), blur: 15, y: 3)]
                                          ),

                                          child: SvgPicture.asset(AppAssets.minSvg),
                                        ),
                                      ),


                                      
                                      Container(
                                        alignment: Alignment.center,
                                        width: 44,
                                        child: Text(
                                          quizData!.questions![currentQuestionIndex].gradeForUser?.toString() ?? '',
                                          style: style16Bold(),
                                        ),
                                      ),

                                      
                                      
                                      // max
                                      GestureDetector(
                                        onTap: (){
                                          if(quizData!.questions![currentQuestionIndex].gradeForUser! < (int.parse(quizData!.questions![currentQuestionIndex].grade ?? '0'))){
                                            setState(() {
                                              quizData!.questions![currentQuestionIndex].gradeForUser ??= 0; 
                                              quizData!.questions![currentQuestionIndex].gradeForUser = quizData!.questions![currentQuestionIndex].gradeForUser! + 1;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: padding(horizontal: 12, vertical: 18),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: borderRadius(radius: 12),
                                            boxShadow: [boxShadow(Colors.black.withOpacity(.05), blur: 15, y: 3)]
                                          ),

                                          child: SvgPicture.asset(AppAssets.plusLineSvg),
                                        ),
                                      ),

                                    ],
                                  )

                                  
                                ],
                              ),

                            }

                          }else...{

                            SizedBox(
                              width: getSize().width,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 3.8/4
                                ), 
                                itemCount: quizData?.questions?[currentQuestionIndex].answers?.length ?? 0,
                                
                                itemBuilder: (context, index) {
                                  
                                  return GestureDetector(
                                    onTap: (){

                                      if(isReview){
                                        return;
                                      }
              
                                      for (var element in quizData!.questions![currentQuestionIndex].answers!) {
                                        element?.isSelected = false;
                                      }
              
                                      setState(() {
                                        quizData!.questions![currentQuestionIndex].answers![index]!.isSelected = true;
                                      });

                                    }, 
                                    child: QuizWidget.multiAnswerItem(
                                      quizData!.questions![currentQuestionIndex].answers![index]!,
                                      isReview,
                                      userAnswer: reviewQuizData?.answersheet?.items.keys.toList().singleWhere((element) => quizData!.questions![currentQuestionIndex].id.toString() == element, orElse: () => '-') == '-'
                                        ? null
                                        : reviewQuizData?.answersheet?.items[
                                            reviewQuizData?.answersheet?.items.keys.toList().singleWhere((element) {
                                              return quizData!.questions![currentQuestionIndex].id.toString() == element;
                                            })
                                          ]
                                    ),
                                  );
                                },
                              ),
                            ),

                          },
                        },

                        space(140),
            
            
            
                      ],
                      ),
            
                    )
                  ),
                  
            
                ],
              ),
            ),


            // button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              bottom: isStartQuiz ? 0 : -150,
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
                    
                    // Previous
                    Expanded(
                      child: button(
                        onTap: (){
                          if(currentQuestionIndex > 0){
                            setState(() {
                              currentQuestionIndex--;
                            });
                          }
                        }, 
                        width: getSize().width, 
                        height: 52, 
                        text: appText.previous, 
                        bgColor: Colors.white, 
                        textColor: green77(),
                        borderColor: green77()
                      )
                    ),

                    space(0,width: 16),

                    if((currentQuestionIndex + 1) == (quizData?.questions?.length ?? 0))...{

                      // Finish
                      Expanded(
                        child: button(
                          onTap: () async {

                            if(isReview){

                              if(beforTabPage == 'MyResults'){
                                backRoute();
                                
                              }else{
                                setState(() {
                                  isLoadingSendingResult = true;
                                });

                                bool res = await QuizService.storeReview(reviewQuizData!.id!, quizData!.questions!);

                                setState(() {
                                  isLoadingSendingResult = false;
                                });

                                if(res){
                                  if(mounted){
                                    backRoute(arguments: true);
                                    backRoute(arguments: true);
                                  }
                                }
                              }

                            }else{

                              setState(() {
                                isLoadingSendingResult = true;
                              });

                              bool res = await QuizService.storeResult(quizData!.id!, quizResultId!, quizData!.questions!);

                              setState(() {
                                isLoadingSendingResult = false;
                              });

                              if(res){
                                backRoute(arguments: true);
                              }
                            }
                          }, 
                          width: getSize().width, 
                          height: 52, 
                          text: beforTabPage == 'MyResults' ? appText.back : appText.finish, 
                          bgColor: red49, 
                          textColor: Colors.white,
                          isLoading: isLoadingSendingResult
                        )
                      ),
                      
                    }else...{

                      // Next
                      Expanded(
                        child: button(
                          onTap: (){
                            if((currentQuestionIndex + 1) < (quizData?.questions?.length ?? 0)){
                              setState(() {
                                currentQuestionIndex++;
                              });
                            }
                          }, 
                          width: getSize().width,
                          height: 52, 
                          text: appText.next, 
                          bgColor: green77(), 
                          textColor: Colors.white
                        )
                      ),
                    }


                  ],
                )
              ),
            ),

          ],
        ),
      )
    );
  }
}
