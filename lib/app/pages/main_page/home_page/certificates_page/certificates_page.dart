import 'package:flutter/material.dart';
import 'package:webinar/app/models/certificate_model.dart';
import 'package:webinar/app/pages/main_page/home_page/certificates_page/certificates_details_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/certificate_service.dart';
import 'package:webinar/app/widgets/main_widget/quizzes_widget/quizzes_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/locator.dart';
import 'package:html/parser.dart';

class CertificatesPage extends StatefulWidget {
  static const String pageName = '/certificates';
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> with SingleTickerProviderStateMixin{

  late TabController tabController;
  bool isLoadingGetData = false;

  bool isLoadingAchievement = false;
  List<CertificateModel> achievementData = [];
  
  bool isLoadingCompletion = false;
  List<CertificateModel> completionData = [];
  
  bool isLoadingClass = false;
  List<CertificateModel> classData = [];

  @override
  void initState() {
    super.initState();


    if(locator<UserProvider>().profile?.roleName != 'user'){
      tabController = TabController(length: 3, vsync: this);

    }else{
      tabController = TabController(length: 2, vsync: this);
    }

    getData();
  }


  getData(){

    isLoadingAchievement = true;
    isLoadingCompletion = true;

    CertificateService.getAchievements().then((value){
      setState(() {
        isLoadingAchievement = false;
        achievementData = value;
      });
    });

    CertificateService.getCompletion().then((value){
      setState(() {
        isLoadingCompletion = false;
        completionData = value;
      });
    });


    if(locator<UserProvider>().profile?.roleName != 'user'){
      isLoadingClass = true;
      
      CertificateService.getClassData().then((value){
        setState(() {
          isLoadingClass = false;
          classData = value;
        });
      });
    }


  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.certificates),

        body: Column(
          children: [

            space(6),

            tabBar((p0){}, tabController, [
              Tab(text: appText.achievements, height: 32),
              Tab(text: appText.completionCerts, height: 32),

              if(locator<UserProvider>().profile?.roleName != 'user')...{
                Tab(text: appText.classCerts, height: 32),
              }
            ]),

            space(6),


            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [

                  isLoadingAchievement
                ? loading()
                : achievementData.isEmpty
                ? emptyState(AppAssets.certificatesEmptyStateSvg, appText.noCertificates, appText.noCertificatesDesc)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: [

                        space(16),

                        ...List.generate(achievementData.length, (index) {
                          return QuizzesWidget.item(
                            achievementData[index].quiz!, 
                            (){
                              nextRoute(CertificatesDetailsPage.pageName, arguments: [achievementData[index], 'achievements']);
                            },
                            isMyResult: true,
                            userGrade: achievementData[index].userGrade.toString(),
                            status: 'passed',
                            isShowStatus: false
                          );
                        })

                      ],
                    ),
                  ),

                  isLoadingCompletion
                ? loading()
                : completionData.isEmpty
                ? emptyState(AppAssets.certificatesEmptyStateSvg, appText.noCertificates, appText.noCertificatesDesc)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: [

                        space(16),

                        ...List.generate(completionData.length, (index) {
                          return userCard(
                            completionData[index].webinar?.image ?? '', 
                            completionData[index].webinar?.title ?? '', 
                            parse(completionData[index].webinar?.description ?? '').body?.text ?? '', 
                            timeStampToDate((completionData[index].createdAt ?? 0) * 1000), 
                            '', 
                            '', 
                            (){
                              nextRoute(CertificatesDetailsPage.pageName, arguments: [completionData[index], 'completion']);
                            },
                            imageWidth: 130,
                            paddingValue: 8,
                            titleAndDescSpace: 10
                          );
                        })

                      ],
                    ),
                  ),



                  if(locator<UserProvider>().profile?.roleName != 'user')...{
                    isLoadingClass
                  ? loading()
                  : classData.isEmpty
                  ? emptyState(AppAssets.certificatesEmptyStateSvg, appText.noCertificates, appText.noCertificatesDesc)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),

                      child: Column(
                        children: [

                          space(16),

                          ...List.generate(classData.length, (index) {
                            return userCard(
                              classData[index].webinar?.image ?? '', 
                              classData[index].webinarTitle ?? '', 
                              '${appText.passMark}: ${classData[index].passMark ?? '-'} | ${appText.averageGrade}: ${classData[index].averageGrade ?? '-'}', 
                              timeStampToDate((classData[index].createdAt ?? 0) * 1000), 
                              '', 
                              '', 
                              (){

                              },
                              imageWidth: 0,
                              paddingValue: 8,
                              titleAndDescSpace: 5
                            );
                          })

                        ],
                      ),
                    ),
                  }

                ]
              )
            )
          ],
        ),

      )
    );
  }
}