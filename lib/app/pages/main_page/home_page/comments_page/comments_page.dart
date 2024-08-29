import 'package:flutter/material.dart';
import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/single_course_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/comments_service.dart';
import 'package:webinar/app/widgets/main_widget/comments_widget/comments_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/locator.dart';

import 'comment_details_page.dart';

class CommentsPage extends StatefulWidget {
  static const String pageName = '/comments';
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> with TickerProviderStateMixin{

  bool isLoading = false;
  late TabController tabController;

  List<Comments> myComments = [];
  List<Comments> myClassComments = [];

  @override
  void initState() {
    super.initState();

    if(locator<UserProvider>().profile?.roleName != 'user'){
      tabController = TabController(length: 2, vsync: this);
    }else{
      tabController = TabController(length: 1, vsync: this);
    }

    getData();
  }

  getData() async {

    setState(() {
      isLoading = true;
    });

    var data = await CommentsService.getAllComments();

    myComments = data.$1;
    myClassComments = data.$2;

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.comments),

        body: isLoading
      ? loading()
      : Column(
          children: [
            space(6),


            tabBar((p0) => null, tabController, [
              
              Tab(
                text: appText.myComments,
                height: 32,
              ),
              
              if(locator<UserProvider>().profile?.roleName != 'user')...{
                Tab(
                  text: appText.myClassComments,
                  height: 32,
                ),
              }
              
            ]),


            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [

                  // my comments
                  myComments.isEmpty
                ? emptyState(AppAssets.commentsEmptyStateSvg, appText.noComments, appText.thereIsNoInformationToDisplay)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding(),
                    child: Column(
                      children: [

                        space(10),

                        ...List.generate(myComments.length, (index) {
                          return CommentsWidget.myCommnetsItem(
                            myComments[index],
                            () async {
                              bool? res = await nextRoute(CommentDetailsPage.pageName, arguments: [myComments[index], true]);

                              if(res != null && res){
                                getData();
                              }
                            }
                          );
                        })

                      ],
                    ),
                  ),

                  
                  if(locator<UserProvider>().profile?.roleName != 'user')...{
                    
                    // my class comments
                    myClassComments.isEmpty
                  ? emptyState(AppAssets.commentsEmptyStateSvg, appText.noComments, appText.thereIsNoInformationToDisplay)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: padding(),
                      child: Column(
                        children: [

                          space(10),

                          ...List.generate(myClassComments.length, (index) {
                            // print(myClassComments[index].)
                            return userCard(
                              myClassComments[index].user?.avatar ?? '', 
                              myClassComments[index].user?.fullName ?? '', 
                              myClassComments[index].webinar?.title ?? '', 
                              timeStampToDateHour((myClassComments[index].createAt ?? 0) * 1000), 
                              '', 
                              myClassComments[index].status ?? '',
                              (){
                                nextRoute(CommentDetailsPage.pageName, arguments: [myClassComments[index], false]);
                              },
                              onTapSubtitle: (){
                                nextRoute(SingleCoursePage.pageName, arguments: [myClassComments[index].webinar?.id, myClassComments[index].webinar?.type == 'bundle', myClassComments[index].id]);
                              }
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