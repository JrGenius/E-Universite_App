import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/quize_model.dart';
import 'package:webinar/app/pages/main_page/home_page/quizzes_page/quiz_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';

class QuizInfoPage extends StatefulWidget {
  static const String pageName = '/quiz-info';
  const QuizInfoPage({super.key});

  @override
  State<QuizInfoPage> createState() => _QuizInfoPageState();
}

class _QuizInfoPageState extends State<QuizInfoPage> {

  QuizModel? quizAllData;
  Quiz? quizData;
  int? userGrade;
  String status='';

  String beforTabName = '';

  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();

    _controllerCenter = ConfettiController(duration: const Duration(milliseconds: 3500));

    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      if((ModalRoute.of(context)!.settings.arguments as List)[0] is QuizModel){
        quizAllData = (ModalRoute.of(context)!.settings.arguments as List)[0];
        quizData = quizAllData?.quiz;
      }else{
        quizData = (ModalRoute.of(context)!.settings.arguments as List)[0];
      }

      status = (ModalRoute.of(context)!.settings.arguments as List)[1];
      
      
      
      try{
        userGrade = (ModalRoute.of(context)!.settings.arguments as List)[2];
      }catch(_){}
      
      try{
        beforTabName = (ModalRoute.of(context)!.settings.arguments as List)[3];
      }catch(_){}


      setState(() {});

      if(status == 'passed'){
        Future.delayed(const Duration(seconds: 1)).then((value) {
          _controllerCenter.play();
          setState(() {});
        });
      }


    });

  }
  

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.quizInfomration),

        body: quizData == null
      ? const SizedBox()
      : Stack(
          children: [

            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),
            
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    space(16),
            
                    Text(
                      quizData?.title ?? '',
                      style: style16Bold(),
                    ),
            
                    space(4),
            
                    if(userGrade == null)...{
                      
                      Text(
                        quizData?.webinar?.title ?? '',
                        style: style12Regular().copyWith(color: greyA5),
                      ),
                    },
                    
                    space(40),
            
                    if(userGrade == null && (beforTabName != 'List'))...{
                      Center(
                        child: SvgPicture.asset(
                          AppAssets.quizInfoSvg,
                          width: getSize().width * .6,
                        ),
                      )
                    }else if( userGrade != null || (beforTabName == 'List')) ...{
            
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            
            
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: beforTabName == 'List'
                                ? green77()
                                : status == 'waiting'
                                    ? yellow29
                                    : status == 'passed'
                                      ? green77()
                                      : red49,
            
                                  width: 15
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  boxShadow(
                                    beforTabName == 'List'
                                      ? green77().withOpacity(.25)
                                      : status == 'waiting'
                                          ? yellow29.withOpacity(.25)
                                          : status == 'passed'
                                            ? green77().withOpacity(.25)
                                            : red49.withOpacity(.25), 
                                    blur: 30, y: 2
                                  )
                                ]
                              ),
            
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
            
                                  Text(
                                    beforTabName == 'List'
                                        ? quizData?.avrage.isNaN ? '-' : quizData?.avrage?.toInt().toString() ?? '-'
                                        : userGrade?.toString() ?? '-',
                                    style: style48Bold().copyWith(height: .9),
                                  ),
            
                                  Text(
                                    beforTabName == 'List' 
                                  ? appText.averageGrade 
                                  : isTeacher()
                                    ? appText.studentGrade
                                    : appText.yourGrade,
                                    style: style12Regular().copyWith(color: greyA5),
                                  )
            
            
                                ],
                              ),
                            ),
            
            
                            // small circle
                            Positioned(
                              top: -12,
                              right: 0,
                              left: 0,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: beforTabName == 'List'
                                ? green77()
                                : status == 'passed' 
                                    ? green77() 
                                    : status == 'waiting'
                                      ? yellow29
                                      : red49,
                                  shape: BoxShape.circle,
                                ),
            
                                alignment: Alignment.center,
                                child: status == 'passed' 
                                  ? SvgPicture.asset(AppAssets.checkSvg, width: 18,) 
                                  : status == 'waiting'
                                    ? SvgPicture.asset(AppAssets.more3CircleSvg) 
                                    : status == 'failed'
                                      ? SvgPicture.asset(AppAssets.clearSvg)
                                      : SvgPicture.asset(AppAssets.chart2Svg) ,
                              )
                            ),
            
            
                            if(status == 'passed' && (beforTabName != 'List' && beforTabName != 'StudentResults' ))...{
                              Align(
                                alignment: Alignment.center,
                                child: ConfettiWidget(
                                  confettiController: _controllerCenter,
                                  blastDirectionality: BlastDirectionality.explosive,
                                  gravity: 0.15,
                                  colors: const [
                                    Colors.green,
                                    Colors.blue,
                                    Colors.pink,
                                    Colors.orange,
                                    Colors.purple
                                  ], 
                                ),
                              ),
                            },
            
                          ],
                        ),
                      ),
            
            
                      if(status == 'passed' || status == 'waiting' || status == 'failed')...{
                        
                        Column(
                          children: [
            
                            space(50,width: getSize().width),
            
                            Text(
                              status == 'waiting'
                              ? isTeacher()
                                ? appText.reviewTheResult
                                : appText.waitForFinalResult
                              : status == 'passed'
                                ? beforTabName == 'StudentResults' ? appText.studentPassedTheQuiz : appText.youPassedTheQuiz
                                : appText.youFailedTheQuiz,
            
                              style: style20Bold(),
                            ),
            
                            space(6),
            
                            Text(
                              status == 'waiting'
                              ? isTeacher()
                                ? appText.reviewTheResultDesc
                                : appText.waitForFinalResultDesc
                              : status == 'passed'
                                ? beforTabName == 'StudentResults' ? '' : appText.youPassedTheQuizDesc
                                : appText.youFailedTheQuizDesc,
            
                              style: style14Regular().copyWith(color: greyA5),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
            
                      }
                      
            
                    },
            
                    space(40),
            
                    // info
                    Container(
                      padding: padding(),
                      width: getSize().width,
                      child: Wrap(
                        runSpacing: 21,
                        children: [
                          
                          SingleCourseWidget.courseStatus(
                            appText.totalMark, 
                            quizData?.totalmark?.toString() ?? '-', 
                            AppAssets.starSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.passMark, 
                            quizData?.passmark?.toString() ?? '-', 
                            AppAssets.tickSquareSvg,
                            width:(getSize().width * .5) - 42,
                          ),
            
                          if( !isTeacher() )...{
                            
                            if(beforTabName == 'List')...{
                              SingleCourseWidget.courseStatus(
                                appText.questions, 
                                quizData?.questioncount?.toString() ?? '-', 
                                AppAssets.questionmarkSvg,
                                width:(getSize().width * .5) - 42,
                              ),
                            }else...{

                              if(beforTabName == 'NotParticipated')...{

                                SingleCourseWidget.courseStatus(
                                  appText.attempts, 
                                  quizData?.attempt?.toString() ?? '-', 
                                  AppAssets.plusSvg,
                                  width:(getSize().width * .5) - 42,
                                ),
                              }else...{

                                SingleCourseWidget.courseStatus(
                                  appText.yourGrade, 
                                  userGrade?.toString() ?? '-', 
                                  AppAssets.profileSvg,
                                  width:(getSize().width * .5) - 42,
                                ),
                              }
                            }
            
                            
            
                          }else...{
            
                            SingleCourseWidget.courseStatus(
                              appText.student, 
                              quizAllData?.user?.fullName.toString() ?? '-', 
                              AppAssets.profileSvg,
                              width:(getSize().width * .5) - 42,
                            ),

                            if(isTeacher())...{

                              SingleCourseWidget.courseStatus(
                                appText.attempts, 
                                quizAllData?.quiz?.attemptstate ?? '-', 
                                AppAssets.plusSvg,
                                width:(getSize().width * .5) - 42,
                              ),
                              
                              SingleCourseWidget.courseStatus(
                                appText.submitDate, 
                                timeStampToDate((quizAllData?.quiz?.createdat ?? 0) * 1000), 
                                AppAssets.calendarSvg,
                                width:(getSize().width * .5) - 42,
                              ),
            
                            }else...{
            
                              SingleCourseWidget.courseStatus(
                                appText.attempts, 
                                quizAllData?.quiz?.attemptstate ?? '-', 
                                AppAssets.plusSvg,
                                width:(getSize().width * .5) - 42,
                              ),
                            
                              SingleCourseWidget.courseStatus(
                                appText.time, 
                                '${quizData?.time?.toString() ?? '0'} ${appText.min}', 
                                AppAssets.profileSvg,
                                width:(getSize().width * .5) - 42,
                              ),
                            },
            
                          },

                          if(beforTabName == 'List')...{
                            SingleCourseWidget.courseStatus(
                              appText.time, 
                              '${quizData?.time ?? 0} ${appText.min}',
                              AppAssets.moreCircleSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                           
                            SingleCourseWidget.courseStatus(
                              appText.students, 
                              '${quizData?.studentcount ?? ''}',
                              AppAssets.profileSvg,
                              width:(getSize().width * .5) - 42,
                            ),

                            SingleCourseWidget.courseStatus(
                              appText.dateCreated, 
                              timeStampToDate((quizData?.createdat ?? 0) * 1000),
                              AppAssets.moreCircleSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                          },


                          if(beforTabName == 'NotParticipated')...{

                            SingleCourseWidget.courseStatus(
                              appText.time,
                              '${quizData?.time?.toString() ?? ''} ${appText.min}',
                              AppAssets.timeCircleSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                          }else...{

                            SingleCourseWidget.courseStatus(
                              appText.status, 
                              status == 'passed'
                              ? appText.passed
                              : status == 'failed'
                                ? appText.failed
                                : appText.waiting,
                              AppAssets.moreCircleSvg,
                              width:(getSize().width * .5) - 42,
                            ),
                          }
            
            
                        ],
                      ),
                    )
            
            
            
                  ],
                ),
              ),
            ),

            pageButton()

          ],
        ),

      )
    );
  }


  bool isTeacher(){
    return (locator<UserProvider>().profile?.id ?? -1) == quizData?.teacher?.id;
  }


  Widget pageButton(){

    Widget? child;

    if(beforTabName == 'List'){
      child = button(
        onTap: (){
          backRoute();
        }, 
        width: getSize().width, 
        height: 52, 
        text: appText.backToQuizzes, 
        bgColor: green77(), 
        textColor: Colors.white
      );

      return AnimatedPositioned(
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

          child: child
        ),
      );
    }

    if(isTeacher() && beforTabName == 'StudentResults'){
      
      if(status == 'waiting' && (quizAllData?.reviewable ?? false) ){
        child = button(
          onTap: (){
            nextRoute(
              QuizPage.pageName, 
              arguments: [
                QuizModel.fromJson(quizAllData!.toJson()), 
                true,
                beforTabName
              ]
            );
          }, 
          width: getSize().width, 
          height: 52, 
          text: appText.reviewQuiz, 
          bgColor: green77(), 
          textColor: Colors.white
        );
      }

      
    }else{

      if(quizData?.authstatus != 'passed' && beforTabName == 'MyResults'){
        child = button(
          onTap: () async {
            
            bool? res = await nextRoute(QuizPage.pageName, arguments: [Quiz.fromJson(quizData!.toJson())] );

            if(res != null && res){
              backRoute();
            }

          }, 
          width: getSize().width, 
          height: 52, 
          text: appText.start, 
          bgColor: green77(), 
          textColor: Colors.white
        );
      
      }else{

        child = beforTabName == 'NotParticipated'
      ? button(
          onTap: () async {
            bool? res = await nextRoute(QuizPage.pageName, arguments: [Quiz.fromJson(quizData!.toJson())] );

            if(res != null && res){
              backRoute();
            }
          }, 
          width: getSize().width, 
          height: 51, 
          text: appText.start, 
          bgColor: green77(), 
          textColor: Colors.white
        )
      : Row(
          children: [

            if(status != 'waiting')...{

              Expanded(
                child: button(
                  onTap: () async {

                    if(status == 'passed'){
                      nextRoute(
                        QuizPage.pageName, 
                        arguments: [
                          Quiz.fromJson(quizData!.toJson()) , 
                          true,
                          beforTabName
                        ]
                      );

                    }else{
                      bool? res = await nextRoute(QuizPage.pageName, arguments: [Quiz.fromJson(quizData!.toJson())] );

                      if(res != null && res){
                        backRoute();
                      }
                    }
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: status == 'passed' ? appText.reviewAnswers : appText.retry,
                  bgColor: Colors.white, 
                  textColor: green77(),
                  borderColor: green77()
                )
              ),

              space(0,width: 16),
            },


            backToQuizzesButton(),

          ],
        );
      }
    }






    if(child == null){
      return const Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: SizedBox()
      );
    }

    return AnimatedPositioned(
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

        child: child
      ),
    );
  }


  Widget backToQuizzesButton(){
    return Expanded(
      child: button(
        onTap: (){
          backRoute();
        }, 
        width: getSize().width, 
        height: 52, 
        text: appText.backToQuizzes, 
        bgColor: green77(), 
        textColor: Colors.white
      )
    );
  }

  
}