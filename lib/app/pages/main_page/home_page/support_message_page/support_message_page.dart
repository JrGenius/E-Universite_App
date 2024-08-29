import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/support_service.dart';
import 'package:webinar/app/widgets/main_widget/support_widget/support_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/locator.dart';

import '../../../../../common/badges.dart';
import '../../../../../config/assets.dart';
import '../../../../../config/colors.dart';
import '../../../../../config/styles.dart';
import '../../../../models/support_model.dart';
import 'conversation_page.dart';

class SupportMessagePage extends StatefulWidget {
  static const String pageName = '/support-message';
  const SupportMessagePage({super.key});

  @override
  State<SupportMessagePage> createState() => _SupportMessagePageState();
}

class _SupportMessagePageState extends State<SupportMessagePage> with TickerProviderStateMixin{

  late TabController tabController;

  bool isLoadingTickets = false;
  List<SupportModel> ticketsData = [];

  bool isLoadingClasses = false;
  List<SupportModel> classSupportData = [];
  
  bool isLoadingMyClasss = false;
  List<SupportModel> myClassSupportData = [];

  int currentTab = 0;


  @override
  void initState() {
    super.initState();

    if(locator<UserProvider>().profile?.roleName != 'user'){
      tabController = TabController(length: 3, vsync: this);
    }else{
      tabController = TabController(length: 2, vsync: this);
    }

    tabController.addListener(() { 
      setState(() {
        currentTab = tabController.index;
      });
    });

    getData();

  }


  getData(){
    
    isLoadingTickets = true;
    isLoadingClasses = true;

    SupportService.getTickets().then((value) {
      ticketsData = value;
      isLoadingTickets = false;

      setState(() {});
    });

    SupportService.getClassSupport().then((value) {
      classSupportData = value;
      isLoadingClasses = false;

      setState(() {});
    });

    if(locator<UserProvider>().profile?.roleName != 'user'){
      isLoadingMyClasss = true;
      
      SupportService.getMyClassSupport().then((value) {
        myClassSupportData = value;
        isLoadingMyClasss = false;

        setState(() {});
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.support_messages),

        body: Column(
          children: [

            space(6),

            tabBar((p0) {}, tabController, [
              Tab(text: appText.tickets, height: 32),
              Tab(text: appText.classesSupport, height: 32),
              
              if(locator<UserProvider>().profile?.roleName != 'user')...{
                Tab(text: appText.myClassesSupport, height: 32),
              }

            ]),

            space(6),


            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: [

                isLoadingTickets
                ? loading()
                : ticketsData.isEmpty
                ? Center(child: emptyState(AppAssets.commentsEmptyStateSvg, appText.noTickets, appText.noTicketsDesc))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: List.generate(ticketsData.length, (index) {
                        return item(
                          ticketsData[index].title ?? '', 
                          timeStampToDateHour((ticketsData[index].createdAt ?? 0) * 1000), 
                          ticketsData[index].status ?? '', 
                          (){
                            nextRoute(ConversationPage.pageName, arguments: ticketsData[index].id);
                          }
                        );
                      }),
                    ),
                  ),
                  

                isLoadingClasses
                ? loading()
                : classSupportData.isEmpty
                ? Center(child: emptyState(AppAssets.commentsEmptyStateSvg, appText.noTickets, appText.noTicketsDesc))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),

                    child: Column(
                      children: List.generate(classSupportData.length, (index) {
                        return item(
                          classSupportData[index].title ?? '', 
                          timeStampToDateHour((classSupportData[index].createdAt ?? 0) * 1000), 
                          classSupportData[index].status ?? '', 
                          (){
                            nextRoute(ConversationPage.pageName, arguments: classSupportData[index].id);
                          }
                        );
                      }),
                    ),
                  ),

                  
                  if(locator<UserProvider>().profile?.roleName != 'user')...{
                    
                    isLoadingMyClasss
                  ? loading()
                  : myClassSupportData.isEmpty
                  ? Center(child: emptyState(AppAssets.commentsEmptyStateSvg, appText.noTickets, appText.noContentForShow))
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),

                      child: Column(
                        children: List.generate(myClassSupportData.length, (index) {
                          return item(
                            myClassSupportData[index].title ?? '', 
                            timeStampToDateHour((myClassSupportData[index].createdAt ?? 0) * 1000), 
                            myClassSupportData[index].status ?? '', 
                            (){
                              nextRoute(ConversationPage.pageName, arguments: myClassSupportData[index].id);
                            }
                          );
                        }),
                      ),
                    )
                    
                  }
                  

                ]
              )
            )
          ],
        ),

        floatingActionButton: currentTab == 2
      ? const SizedBox()
      : button(
          onTap: () async {

            if(currentTab == 0){
              
              bool? res = await SupportWidget.newSupportMessageSheet();

              if(res != null && res){
                getData();
              }

            }else if(currentTab == 1){

              bool? res = await SupportWidget.newSupportMessageForClassesSheet();

              if(res != null && res){
                getData();
              }
            }

          }, 
          width: 52, 
          height: 52, 
          text: '', 
          bgColor: green77(), 
          textColor: Colors.white,
          boxShadow: boxShadow(green77().withOpacity(.3), y: 6, blur: 10),
          iconPath: AppAssets.plusLineSvg,
          iconColor: Colors.white,
          icWidth: 18
        ),

      )
    );
  }



  Widget item(String title, String date, String status, Function onTap){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: getSize().width,
        margin: const EdgeInsets.only(bottom: 16),
        padding: padding(horizontal: 13,vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius(radius: 16)
        ),
    
        child: Row(
          children: [
    
            // icon
            Container(
              width: 65,
              height: 65,
    
              decoration: BoxDecoration(
                color: green77(),
                borderRadius: borderRadius(radius: 14)
              ),
    
              child: Center(child: SvgPicture.asset(AppAssets.commentsSvg, width: 23,)),
            ),
    
            space(0, width: 10),
    
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
    
                  Text(
                    title,
                    style: style14Bold(),
                  ),
    
                  space(8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        date,
                        style: style12Regular().copyWith(color: greyA5),
                      ),

                      if(status == 'close')...{
                        Badges.closed(),
                      }else if(status == 'replied')...{
                        Badges.replied(),
                      }else...{
                        Badges.waiting(),
                      },

                    ],
                  ),

                ],
              )
            )
    
          ],
        ),
      ),
    );
  }

}