import 'package:flutter/material.dart';
import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/pages/main_page/providers_page/user_profile_page/select_date_page.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/guest_service/providers_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

import '../../../../widgets/main_widget/provider_widget/user_profile_widget.dart';

class UserProfilePage extends StatefulWidget {
  static const String pageName = '/user-profile';
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with TickerProviderStateMixin{

  bool isLoading = true;

  ProfileModel? profile;
  late TabController tabController;

  int currentTab=0;

  bool isShowAboutButton = true;
  bool isShowMeetingButton = false;

  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    

    tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int? id = ModalRoute.of(context)!.settings.arguments as int;

      getData(id);
    });


    tabController.addListener(() {
      onChangeTab(tabController.index);
    });
    
  }


  getData(int id) async {
    setState(() {
      isLoading = true;
    });
    
    profile = await ProvidersService.getUserProfile(id);
    
    
    if(profile?.roleName == 'organization'){
      tabController = TabController(length: 5, vsync: this);
    }
    
    setState(() {
      isLoading = false;
    });
  }

  offAllButton(){
    isShowAboutButton = false;
    isShowMeetingButton = false;
  }

  onChangeTab(int tab){
    offAllButton();

    if(tab == 0){
      offAllButton();
      isShowAboutButton = true;
    }
    
    if(tab == 3){
      offAllButton();
      isShowMeetingButton = true;
    }

    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: profile?.fullName ?? ''),

        body: isLoading
      ? loading()
      : Stack(
          children: [

            Positioned.fill(
              child: NestedScrollView(
                headerSliverBuilder: (_,__){
                  return [
                    
                    // image + name + 3 item
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          space(20),

                          // image
                          Stack(
                            children: [
                              ClipRRect(  
                                borderRadius: borderRadius(radius: 100),
                                child: fadeInImage(profile?.avatar ?? '', 100, 100),
                              ),  

                              if(profile?.verified == 1)...{
                                PositionedDirectional(
                                  end: 0,
                                  top: 12,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: blueFE
                                    ),
                                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                                  )
                                ),
                              }

                            ],
                          ),

                          space(20),

                          Text(
                            profile?.fullName ?? '',
                            style: style20Bold(),
                          ),

                          space(6),

                          ratingBar(profile?.rate ?? '0', itemSize: 15),

                          space(24),

                          // classes + students + followers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              const SizedBox(),

                              // classes
                              UserProfileWidget.profileItem(appText.classes, profile?.webinars?.length.toString() ?? '0', AppAssets.videoSvg, green50),
                              
                              // students
                              UserProfileWidget.profileItem(appText.students, profile?.students?.length.toString() ?? '0', AppAssets.profileSvg, blueFE, width: 25),
                              
                              // followers
                              UserProfileWidget.profileItem(appText.followers, profile?.followersCount.toString() ?? '0', AppAssets.provideresSvg, yellow29, width: 25),

                              const SizedBox(),

                            ],
                          ),
                          
                          space(12),

                        ],
                      ),
                    ),

                    // tab
                    SliverAppBar(
                      titleSpacing: 0,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: greyFA,
                      shadowColor: Colors.grey.withOpacity(.12),
                      elevation: 8,
                      title: SizedBox(
                        width: getSize().width,
                        child: tabBar(
                          (i) {
                            onChangeTab(i);
                          }, 
                          tabController, 
                          [
                            Tab(
                              height: 32,
                              child: Text(
                                appText.about,
                              ),
                            ),

                            Tab(
                              height: 32,
                              child: Text(
                                appText.classes
                              ),
                            ),

                            Tab(
                              height: 32,
                              child: Text(
                                appText.badges
                              ),
                            ),

                            Tab(
                              height: 32,
                              child: Text(
                                appText.meeting
                              ),
                            ),

                            if(profile?.roleName == 'organization')...{
                              Tab(
                                height: 32,
                                child: Text(
                                  appText.instrcutors
                                ),
                              ),
                            }
                            
                          ],
                          horizontalPadding: 24
                        )
                      ),
                    ),

                  ];
                }, 
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  children: [

                    UserProfileWidget.aboutPage(profile ?? ProfileModel()),

                    UserProfileWidget.classesPage(profile ?? ProfileModel()),

                    UserProfileWidget.badgesPage(profile ?? ProfileModel()),

                    UserProfileWidget.meetingPage(profile ?? ProfileModel()),

                    if(profile?.roleName == 'organization')...{
                      UserProfileWidget.instructorPage(profile  ?? ProfileModel(),),
                    }

                  ]
                )
              )
            ),


            // about button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: isShowAboutButton ? 0 : -150,
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

                    Expanded(
                      child: button(
                        onTap: (){

                          if(locator<UserProvider>().profile != null){
                            
                            profile?.authUserIsFollower = !(profile?.authUserIsFollower ?? false);
                            ProvidersService.follow(profile!.id!, (profile?.authUserIsFollower ?? false));

                            setState(() {});
                          }
                        }, 
                        width: getSize().width, 
                        height: 51, 
                        text: (profile?.authUserIsFollower ?? false) ? appText.unFollow : appText.follow, 
                        bgColor: Colors.white, 
                        textColor: green77(),
                        borderColor: green77()
                      )
                    ),

                    if(profile?.publicMessage == 1)...{
                      space(0,width: 20),
                      
                      Expanded(
                        child: button(
                          onTap: (){
                            UserProfileWidget.showSendMessageDialog(profile!.id!);
                          }, 
                          width: getSize().width, 
                          height: 51, 
                          text: appText.sendMessage, 
                          bgColor: green77(), 
                          textColor: Colors.white
                        )
                      ),

                    }

                  ],
                ),
              ),
            ),

            // meeting button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: isShowMeetingButton ? 0 : -150,
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

                child: Column(
                  children: [
                    
                    // title and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          appText.hourlyCharge,
                          style: style14Regular().copyWith(color: greyA5),
                        ),

                        Row(
                          children: [
                            
                            if(profile?.meeting?.discount != null)...{
                              Text(
                                CurrencyUtils.calculator(profile?.meeting?.price ?? 0),
                                style: style14Regular().copyWith(color: greyA5,decoration: TextDecoration.lineThrough),
                              ),

                              space(0,width: 8),
                            },
                              
                            Text(
                              CurrencyUtils.calculator(profile?.meeting?.priceWithDiscount ?? 0),
                              style: style16Bold().copyWith(color: green77()),
                            ),

                          ],
                        )

                      ],
                    ),

                    space(16),
                    
                    button(
                      onTap: (){
                        baseBottomSheet(child: SelectDatePage(profile!.id!, profile!));
                      }, 
                      width: getSize().width, 
                      height: 51, 
                      text: appText.reserveMeeting, 
                      bgColor: green77(), 
                      textColor: Colors.white
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      )
    );
  }
}