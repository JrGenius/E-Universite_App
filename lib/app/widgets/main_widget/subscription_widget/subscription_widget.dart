import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/app/models/saas_package_model.dart';
import 'package:webinar/app/models/subscription_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';

class SubscriptionWidget{

  static Widget subscriptionPage(PageController pageController, SubscriptionModel? data, int currentPage,Function(int i) changePage, bool isLoading, Function onTap){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          space(16),

          // active subscription
          Container(
            margin: padding(),
            width: getSize().width,
            padding: padding(horizontal: 10, vertical: 18),
            
            decoration: BoxDecoration(
              border: Border.all(
                color: greyE7,
              ),
              borderRadius: borderRadius()
            ),

            child: !(data?.subscribed ?? false)
          ? Column(
              children: [

                SvgPicture.asset(AppAssets.subscriptionEmptyStateSvg),

                space(16),

                Text(
                  appText.noActiveSubscriptionPlan,
                  style: style14Regular().copyWith(color: greyA5),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                // active plan
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: green50.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.shieldSvg,colorFilter: ColorFilter.mode(green50, BlendMode.srcIn)),
                    ),

                    space(6),

                    Text(
                      data?.subscribedTitle ?? '-',
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.activePlan,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),
                
                // remained downloads
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: blueFE.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.paperDownloadSvg,colorFilter: ColorFilter.mode(blueFE, BlendMode.srcIn)),
                    ),

                    space(6),

                    Text(
                      data?.remainedDownloads?.toString() ?? '-',
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.remainedDownloads,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),
                
                // remained days
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: yellow29.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.paperDownloadSvg,colorFilter: ColorFilter.mode(yellow29, BlendMode.srcIn)),
                    ),

                    space(6),

                    Text(
                      data?.daysRemained?.toString() ?? '-',
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.remainedDays,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),

              ],
            ),
          ),

          space(35),

          // select A Plan
          Padding(
            padding: padding(),
            child: Text(
              appText.selectAPlan,
              style: style14Bold(),
            ),
          ),
          
          space(30),

          SizedBox(
            width: getSize().width,
            height: 400,
            child: PageView(
              onPageChanged: (value) {
                changePage(value);
              },
              controller: pageController,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              children: [

                ...List.generate(data?.subscribes?.length ?? 0, (index) {
                  return SizedBox(
                    width: getSize().width,
                    height: 400,

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [

                        // bg
                        Positioned(
                          bottom: 0,
                          right: 36,
                          left: 36,
                          child: Container(
                            width: getSize().width,
                            height: 380,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius()
                            ),
                          )
                        ),

                        // details
                        Positioned(
                          bottom: 10,
                          right: 21,
                          left: 21,
                          child: Container(
                            width: getSize().width,
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius(),
                              boxShadow: [boxShadow(Colors.black.withOpacity(.03), blur: 15, y: 3)]
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                space(30),

                                Image.network(
                                  data?.subscribes?[index].image ?? '',
                                  width: 90,
                                  height: 90,
                                ),

                                space(14),

                                Text(
                                  data?.subscribes?[index].title ?? '',
                                  style: style24Bold().copyWith(fontSize: 26),
                                ),
                                
                                space(5),
                                
                                Text(
                                  data?.subscribes?[index].description ?? '',
                                  style: style14Regular().copyWith(color: greyA5),
                                ),

                                const Spacer(),

                                Text(
                                  CurrencyUtils.calculator(data?.subscribes?[index].price),
                                  style: style24Bold().copyWith(fontSize: 26, color: green77()),
                                ),
                                
                                space(16),

                                // days and classes count
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 10,
                                    maxWidth: getSize().width
                                  ),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: greyE7),
                                              shape: BoxShape.circle
                                            ),
                                          ),

                                          space(0,width: 4),

                                          Text(
                                            '${data?.subscribes?[index].days} ${appText.daysOfSubscription}',
                                            style: style14Regular().copyWith(color: greyA5),
                                          )

                                        ],
                                      ),

                                      space(15),

                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: greyE7),
                                              shape: BoxShape.circle
                                            ),
                                          ),

                                          space(0,width: 4),

                                          Text(
                                            '${data?.subscribes?[index].usableCount} ${appText.classesSubscription}',
                                            style: style14Regular().copyWith(color: greyA5),
                                          )

                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // button
                                Padding(
                                  padding: padding(horizontal: 16),
                                  child: Center(
                                    child: button(
                                      onTap: () async {
                                    
                                        onTap(data?.subscribes?[index].id);

                                      }, 
                                      width: getSize().width, 
                                      height: 50, 
                                      text: appText.purchase, 
                                      bgColor: green77(), 
                                      textColor: Colors.white,
                                      isLoading: isLoading,
                                    ),
                                  ),
                                ),

                                space(16),

                              ],
                            ),

                          ),
                        )

                      ],
                    ),
                  );
                })
                
              ],
            ),
          ),

          space(16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ...List.generate(data?.subscribes?.length ?? 0, (index) {
                return AnimatedContainer(
                  margin: padding(horizontal: 1.5),
                  duration: const Duration(milliseconds: 300),
                  width: currentPage == index ? 16 : 7,
                  height: 7,
                  
                  decoration: BoxDecoration(
                    color: green77(),
                    borderRadius: borderRadius()
                  ),

                );
              }),
              
            ],
          ),

          space(70),

        ],
      ),
    );
  }

  static Widget saasPackagePage(PageController pageController, SaasPackageModel? data, int currentPage,Function(int i) changePage, bool isLoading, Function onTap){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          space(16),

          // active subscription
          Container(
            margin: padding(),
            width: getSize().width,
            padding: padding(horizontal: 10, vertical: 18),
            
            decoration: BoxDecoration(
              border: Border.all(
                color: greyE7,
              ),
              borderRadius: borderRadius()
            ),

            child: (data?.activePackage == null)
          ? Column(
              children: [

                SvgPicture.asset(AppAssets.subscriptionEmptyStateSvg),

                space(16),

                Text(
                  appText.noContentForShow,
                  style: style14Regular().copyWith(color: greyA5),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                // active plan
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: green50.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.shieldSvg,colorFilter: ColorFilter.mode(green50, BlendMode.srcIn)),
                    ),

                    space(6),

                    Text(
                      data?.activePackage?.title ?? '-',
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.activePlan,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),
                
                // remained downloads
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: blueFE.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.plusSvg, colorFilter: ColorFilter.mode(blueFE, BlendMode.srcIn),width: 20,),
                    ),

                    space(6),

                    Text(
                      timeStampToDate((data?.activePackage?.activationDate ?? 0) * 1000),
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.activationDate,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),
                
                // remained days
                Column(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: yellow29.withOpacity(.3),
                        shape: BoxShape.circle
                      ),

                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppAssets.paperDownloadSvg,colorFilter: ColorFilter.mode(yellow29, BlendMode.srcIn)),
                    ),

                    space(6),

                    Text(
                      data?.activePackage?.daysRemained ?? '-',
                      style: style14Bold(),
                    ),

                    space(3),

                    Text(
                      appText.remainedDays,
                      style: style12Regular().copyWith(color: greyA5),
                      textAlign: TextAlign.center,
                    )

                  ],
                ),

              ],
            ),
          ),

          space(20),

          // account statistics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // account Statistics
              Padding(
                padding: padding(),
                child: Text(
                  appText.accountStatistics,
                  style: style14Bold(),
                ),
              ),

              space(16),

              // data
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: padding(),
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [

                    dashboardInfoBox(
                      green50, 
                      AppAssets.playCircleSvg, 
                      data?.accountCoursesCount?.toString() ?? '-', 
                      appText.newCourses, 
                      (){}
                    ),

                    space(0,width: 15),

                    dashboardInfoBox(
                      red49, 
                      AppAssets.videoSvg, 
                      data?.accountCoursesCapacity?.toString() ?? '-', 
                      appText.liveClassCapacity, 
                      (){}
                    ),
                    
                    space(0,width: 15),

                    dashboardInfoBox(
                      blueA4, 
                      AppAssets.timeCircleSvg, 
                      data?.accountMeetingCount?.toString() ?? '-', 
                      appText.meetingTimeSlots, 
                      (){}
                    ),
                    
                    if(locator<UserProvider>().profile?.roleName == 'organization')...{
                      space(0,width: 15),

                      dashboardInfoBox(
                        cyan50, 
                        AppAssets.provideresSvg, 
                        data?.accountStudentsCount?.toString() ?? '-', 
                        appText.students, 
                        (){}
                      ),
                      
                      space(0,width: 15),

                      dashboardInfoBox(
                        blue64(), 
                        AppAssets.profileSvg, 
                        data?.accountInstructorsCount?.toString() ?? '-', 
                        appText.instrcutors, 
                        (){}
                      ),
                    }

                  ],
                ),
              )

            ],
          ),

          space(20),

          // select A Plan
          Padding(
            padding: padding(),
            child: Text(
              appText.selectAPlan,
              style: style14Bold(),
            ),
          ),
          
          space(30),

          // pageView
          SizedBox(
            width: getSize().width,
            height: 520,
            child: PageView(
              onPageChanged: (value) {
                changePage(value);
              },
              controller: pageController,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              children: [

                ...List.generate(data?.packages?.length ?? 0, (index) {
                  return SizedBox(
                    width: getSize().width,
                    height: 520,

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [

                        // bg
                        Positioned(
                          bottom: 0,
                          right: 36,
                          left: 36,
                          child: Container(
                            width: getSize().width,
                            height: 500,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius()
                            ),
                          )
                        ),

                        // details
                        Positioned(
                          bottom: 10,
                          right: 21,
                          left: 21,
                          child: Container(
                            width: getSize().width,
                            height: 520,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius(),
                              boxShadow: [boxShadow(Colors.black.withOpacity(.03), blur: 15, y: 3)]
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                space(30),

                                Image.network(
                                  data?.packages?[index].icon ?? '',
                                  width: 90,
                                  height: 90,
                                ),

                                space(14),

                                Text(
                                  data?.packages?[index].title ?? '',
                                  style: style24Bold().copyWith(fontSize: 26),
                                ),
                                
                                space(5),
                                
                                Text(
                                  data?.packages?[index].description ?? '',
                                  style: style14Regular().copyWith(color: greyA5),
                                ),

                                const Spacer(),

                                Text(
                                  CurrencyUtils.calculator(data?.packages?[index].price),
                                  style: style24Bold().copyWith(fontSize: 26, color: green77()),
                                ),
                                
                                space(16),

                                // days and classes count
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 10,
                                    maxWidth: getSize().width
                                  ),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      helper('${data?.packages?[index].days} ${appText.daysOfSubscription}'),

                                      space(15),
                                      
                                      helper('${data?.packages?[index].coursesCount} ${appText.course}'),

                                      space(15),
                                      
                                      helper('${data?.packages?[index].coursesCapacity} ${appText.liveClassCapacity}'),

                                      space(15),
                                      
                                      helper('${data?.packages?[index].meetingCount} ${appText.meetingTimeSlots.replaceAll('\n', ' ')}'),

                                      space(15),

                                      helper('${data?.packages?[index].studentsCount} ${appText.students}'),

                                      space(15),
                                      
                                      helper('${data?.packages?[index].instructorsCount} ${appText.instrcutors}'),

                                      space(15),

                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // button
                                Padding(
                                  padding: padding(horizontal: 16),
                                  child: button(
                                    onTap: () async {
                                      
                                      onTap(data?.packages?[index].id);
                                      
                                    }, 
                                    width: getSize().width, 
                                    height: 50, 
                                    text: appText.purchase, 
                                    bgColor: green77(), 
                                    textColor: Colors.white,
                                    isLoading: isLoading,
                                  ),
                                ),

                                space(16),

                              ],
                            ),

                          ),
                        )

                      ],
                    ),
                  );
                })
                
              ],
            ),
          ),

          space(16),

          // indecators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ...List.generate(data?.packages?.length ?? 0, (index) {
                return AnimatedContainer(
                  margin: padding(horizontal: 1.5),
                  duration: const Duration(milliseconds: 300),
                  width: currentPage == index ? 16 : 7,
                  height: 7,
                  
                  decoration: BoxDecoration(
                    color: green77(),
                    borderRadius: borderRadius()
                  ),

                );
              }),
              
            ],
          ),

          space(70),

        ],
      ),
    );
  }





  static Widget helper(String title){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: greyE7),
            shape: BoxShape.circle
          ),
        ),

        space(0,width: 4),

        Text(
          title,
          style: style14Regular().copyWith(color: greyA5),
        )

      ],
    );
  }
}