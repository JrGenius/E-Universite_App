import 'package:flutter/material.dart';
import 'package:webinar/app/models/list_quiz_model.dart';
import 'package:webinar/app/pages/main_page/home_page/quizzes_page/quiz_info_page.dart';
import 'package:webinar/app/widgets/main_widget/quizzes_widget/quizzes_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';

import '../../../../../locator.dart';
import '../../../../models/quize_model.dart';
import '../../../../providers/user_provider.dart';
import '../../../../services/user_service/quiz_service.dart';

class QuizzesPage extends StatefulWidget {
  static const String pageName = '/quizzes';
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> with TickerProviderStateMixin{


  late TabController tabController;

  List<QuizModel> myResults = [];
  bool isLoadingMyResults=false;

  List<Quiz> notParticipated = [];
  bool isLoadingNotParticipated=false;
  
  List<QuizModel> studentResults = [];
  bool isLoadingStudentResults=false;
  
  List<ListQuizModel> listQuiz = [];
  bool isLoadingListQuiz=false;


  @override
  void initState() {
    super.initState();

    tabController = TabController(length: locator<UserProvider>().profile?.roleName != 'user' ? 4 : 2, vsync: this);

    getData();
  }

  getData() async {
    
    isLoadingMyResults = true;
    isLoadingNotParticipated = true;

    QuizService.getMyResults().then((value) {
      myResults = value;
      isLoadingMyResults = false;
      setState(() {});
    });

    QuizService.getNotParticipated().then((value) {
      notParticipated = value;
      isLoadingNotParticipated = false;
      setState(() {});
    });



    if(locator<UserProvider>().profile?.roleName != 'user'){

      isLoadingStudentResults = true;
      QuizService.getStudentResults().then((value) {
        studentResults = value;
        isLoadingStudentResults = false;
        setState(() {});
      });

      
      isLoadingListQuiz = true;
      QuizService.getList().then((value) {
        listQuiz = value;
        isLoadingListQuiz = false;
        setState(() {});
      });


    }

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    // AppData.getAccessToken().then((value) {
    //   print(value);
    // });

    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.quizzes),

        body: Column(
          children: [

            space(6),

            tabBar((p0) {}, tabController, [
              Tab(text: appText.myResults, height: 32),
              Tab(text: appText.notParticipated, height: 32),

              if(locator<UserProvider>().profile?.roleName != 'user')...{
                Tab(text: appText.studentResults, height: 32),
                Tab(text: appText.list, height: 32),
              }
            ]),

            space(6),

            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: [

                  isLoadingMyResults
              ? loading()
              : myResults.isEmpty
                ? emptyState(AppAssets.bioEmptyStateSvg, appText.noResults, appText.youHaveNoQuizResults)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: [

                        space(12),

                        ...List.generate(myResults.length, (index) {
                          return QuizzesWidget.item(
                            myResults[index].quiz!, 
                            () async {
                              await nextRoute(QuizInfoPage.pageName, arguments: [myResults[index].quiz!, myResults[index].status, myResults[index].usergrade, 'MyResults']);

                              getData();
                            },
                            status: myResults[index].status,
                            userGrade: '${myResults[index].usergrade}/${myResults[index].quiz?.totalmark}'
                          );
                        }),
                      ],
                    ),
                  ),


                  isLoadingNotParticipated
                ? loading()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: [

                        space(12),

                        ...List.generate(notParticipated.length, (index) {
                          return QuizzesWidget.item(
                            notParticipated[index], 
                            () async {
                              await nextRoute(QuizInfoPage.pageName, arguments: [notParticipated[index], notParticipated[index].status, null, 'NotParticipated']);

                              getData();
                            }, 
                            isMyResult: false,
                            isShowQuestionCount: true,
                            isShowQuizTime: true
                          );
                        }),
                      ],
                    ),
                  ),


                  if(locator<UserProvider>().profile?.roleName != 'user')...{

                    isLoadingStudentResults
                ? loading()
                : studentResults.isEmpty
                  ? emptyState(AppAssets.bioEmptyStateSvg, appText.noStudentResults, appText.noStudentResultsDesc)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),

                      child: Column(
                        children: [

                          space(12),

                          ...List.generate(studentResults.length, (index) {
                            return userCard(
                              studentResults[index].user?.avatar ?? '', 
                              studentResults[index].user?.fullName ?? '', 
                              studentResults[index].webinar?.title ?? '', 
                              timeStampToDate((studentResults[index].createdat ?? 0) * 1000), 
                              '', 
                              studentResults[index].status ?? '', 
                              () async {
                                await nextRoute(QuizInfoPage.pageName, arguments: [studentResults[index], studentResults[index].status, studentResults[index].usergrade, 'StudentResults']);

                                getData();
                              },
                              gradeStatus: studentResults[index].status,
                              userGrade: '${studentResults[index].usergrade}/${studentResults[index].quiz?.totalmark}'
                            );
                          }),
                        ],
                      ),
                    ),
                    
                    
                    isLoadingListQuiz
                ? loading()
                : listQuiz.isEmpty
                  ? const SizedBox.shrink() // emptyState(AppAssets.bioEmptyStateSvg, appText.noContentForShow, appText.noStudentResultsDesc)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),

                      child: Column(
                        children: [

                          space(12),

                          ...List.generate(listQuiz.length, (index) {
                            return QuizzesWidget.listItem(
                              listQuiz[index], 
                              (){
                                nextRoute(
                                  QuizInfoPage.pageName, 
                                  arguments: [
                                    Quiz.fromJson(listQuiz[index].toJson())
                                      ..title = listQuiz[index].getTitle()
                                      ..questioncount = listQuiz[index].questionCount
                                      ..avrage = listQuiz[index].avrage
                                      ..studentcount = listQuiz[index].studentCount,
                                       
                                    listQuiz[index].status, 
                                    null, 
                                    'List'
                                  ]
                                );

                              }, 
                            );
                          }),
                        ],
                      ),
                    ),
                    

                  }
                ]
              )
            ),

          ],
        ),

      )
    );
  }
}