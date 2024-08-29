import 'package:flutter/material.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/user_model.dart';
import 'package:webinar/app/pages/main_page/providers_page/user_profile_page/user_profile_page.dart';
import 'package:webinar/app/services/guest_service/course_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/tablet_detector.dart';
import 'package:webinar/config/colors.dart';
import '../../../../../config/assets.dart';
import '../../../../../common/components.dart';

class ResultSearchPage extends StatefulWidget {
  static const String pageName = '/result-search-page';
  const ResultSearchPage({super.key});

  @override
  State<ResultSearchPage> createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> with SingleTickerProviderStateMixin{

  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();

  bool isShowButton = false;

  String searchText = '';
  bool isLoading = true;

  List<CourseModel> classesData = [];
  List<UserModel> usersData = [];
  List<UserModel> organizationsData = [];

  late TabController tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      if(searchController.text.trim().isNotEmpty){
        
        if(!isShowButton){
          setState(() {
            isShowButton = true;
          });
        }
      }else{

        if(isShowButton){
          setState(() {
            isShowButton = false;
          });
        }
      }
    });


    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {

      if(tabController.index != currentTab){
        onChangeTab(tabController.index);
      }
    });


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchText = ModalRoute.of(context)!.settings.arguments as String;


      if(searchText.isNotEmpty){
        getData();
      }
    });
  }


  getData() async {
    
    setState(() {
      isLoading = true;
    });

    var res = await CourseService.search(searchText);

    classesData = res.$1;
    usersData = res.$2;
    organizationsData = res.$3;

    setState(() {
      isLoading = false;
    });
  }


  onChangeTab(int i){
    setState(() {
      currentTab = i;
    });
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.search),
      
        body: Stack(
          children: [
            
            Positioned.fill(
              
              top: 20,
              child: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    // input
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      titleSpacing: 0,
                      
                      title: Padding(
                        padding: padding(),
                        child: input(
                          searchController, searchNode, 
                          '${classesData.length + usersData.length + organizationsData.length} ${appText.searchResultDesc} "$searchText"',
                          iconPathLeft: AppAssets.searchSvg, isBorder: true, 
                          fillColor: Colors.transparent
                        ),
                      ),
                    ),
                    
                    // Tab
                    SliverAppBar(
                      pinned: true,
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
                      elevation: 10,
                      titleSpacing: 0,
                      
                      title: tabBar(
                        onChangeTab, 
                        tabController, 
                        [
                          Tab(
                            text: appText.classes + (currentTab == 0 ? ' (${classesData.length}) ' : ''),
                            height: 32,
                          ),
                          
                          Tab(
                            text: appText.users + (currentTab == 1 ? ' (${usersData.length}) ' : ''),
                            height: 32,
                          ),
                    
                          Tab(
                            text: appText.organizations + (currentTab == 2 ? ' (${organizationsData.length}) ' : ''),
                            height: 32,
                          ),
                        ]
                      )
                    ),
                  ];
                },

                body: isLoading
              ? loading()
              : TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  children: [
      
                    // Classes
                    classesData.isEmpty
                  ? emptyState(AppAssets.searchEmptyStateSvg, appText.resultNotFound, appText.tryMoreAccurateWordsToReachResults)
                  : Padding(
                      padding: padding(),
                      child: Column(
                        children: [
                          ...List.generate(classesData.length, (index) {
                            return courseItemVertically(classesData[index]);
                          }),
                        ],
                      ),
                    ),
      
                    // Users
                    usersData.isEmpty
                  ? emptyState(AppAssets.searchEmptyStateSvg, appText.resultNotFound, appText.tryMoreAccurateWordsToReachResults)
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: TabletDetector.isTablet() ? 3 : 2,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 22,
                        mainAxisExtent: 195,
                      ), 
                      padding: padding(),
                      itemCount: usersData.length,
                      itemBuilder: (context, index) {
                        return userProfileCard(usersData[index], (){
                          nextRoute(UserProfilePage.pageName, arguments: usersData[index].id);
                        });
                      },
                    ),
      
                    // Organizations
                    organizationsData.isEmpty
                  ? emptyState(AppAssets.searchEmptyStateSvg, appText.resultNotFound, appText.tryMoreAccurateWordsToReachResults)
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: TabletDetector.isTablet() ? 3 : 2,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 20,
                        childAspectRatio: 22,
                        mainAxisExtent: 195,
                      ), 
                      padding: padding(),
                      itemCount: organizationsData.length,
                      itemBuilder: (context, index) {
                        return userProfileCard(organizationsData[index], (){
                          nextRoute(UserProfilePage.pageName, arguments: organizationsData[index].id);
                        });
                      },
                    ),
      
                  ]
                ),
               
              ),
            ),


            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: isShowButton ? 0 : -150,
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
                  onTap: (){
                    
                    searchText = searchController.text.trim();

                    getData();
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.search, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),
              )
            )

      
          ],
        ),
      )
    );
  }
}