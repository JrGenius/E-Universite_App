import 'package:flutter/material.dart';
import 'package:webinar/app/models/meeting_model.dart';
import 'package:webinar/app/providers/user_provider.dart';
import 'package:webinar/app/services/user_service/meeting_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/locator.dart';

import 'meeting_details_page.dart';

class MeetingsPage extends StatefulWidget {
  static const String pageName = '/meetings';
  const MeetingsPage({super.key});

  @override
  State<MeetingsPage> createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> with SingleTickerProviderStateMixin{

  bool isLoading = false;
  MeetingModel? meetings;

  late TabController tabController;

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
    
    meetings = await MeetingService.getMeetings();
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.meetings),

        body: isLoading
      ? loading()
      : Column(
          children: [

            space(14),

            tabBar((p0) => null, tabController, [
              Tab(text: appText.reserved, height: 32),
              
              if(locator<UserProvider>().profile?.roleName != 'user')...{
                Tab(text: appText.requests, height: 32),
              }
            ]) ,

            space(6),

            Expanded(
              child: isLoading 
            ? loading()
            : TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children:  [

                  // reservations
                  (meetings?.reservations?.meetings?.isEmpty ?? true)
                ? Center(child: emptyState(AppAssets.mettingEmptyStateSvg, appText.noMeetings, appText.noMeetingsDesc))
                : SingleChildScrollView(
                    padding: padding(),
                    physics: const BouncingScrollPhysics(),

                    child: Column(
                      children: [

                        space(12),

                        ...List.generate(meetings?.reservations?.count ?? 0, (index) {
                          return userCard(
                            meetings!.reservations!.meetings![index].user?.avatar ?? '', 
                            meetings!.reservations!.meetings![index].user?.fullName ?? '', 
                            meetings!.reservations!.meetings![index].user?.email ?? '', 
                            timeStampToDateHour((meetings!.reservations!.meetings![index].date ?? 0) * 1000), 
                            '', 
                            meetings!.reservations!.meetings![index].status ?? '', 
                            () async {
                              await nextRoute(
                                MeetingDetailsPage.pageName, 
                                arguments: [
                                  meetings!.reservations!.meetings![index], 
                                  false, 
                                  (meetings!.reservations!.meetings![index].type == 'online' && (meetings!.reservations!.meetings![index].canAgora ?? false))
                                ]
                              );
                              getData();
                            },
                            time: meetings!.reservations!.meetings![index].time,
                          );
                        }),

                        space(12),
                      ],
                    ),
                  ),

                  if(locator<UserProvider>().profile?.roleName != 'user')...{
                  // requests
                  (meetings?.requests?.meetings?.isEmpty ?? true)
                ? Center(child: emptyState(AppAssets.mettingEmptyStateSvg, appText.noMeetings, ''))
                : SingleChildScrollView(
                    padding: padding(),
                    physics: const BouncingScrollPhysics(),

                    child: Column(
                      children: [
                        space(12),

                        ...List.generate(meetings?.requests?.count ?? 0, (index) {
                          return userCard(
                            meetings!.requests!.meetings![index].user?.avatar ?? '', 
                            meetings!.requests!.meetings![index].user?.fullName ?? '', 
                            meetings!.requests!.meetings![index].user?.email ?? '', 
                            timeStampToDateHour((meetings!.requests!.meetings![index].date ?? 0) * 1000), 
                            '', 
                            meetings!.requests!.meetings![index].status ?? '', 
                            () async {
                              await nextRoute(
                                MeetingDetailsPage.pageName, 
                                arguments: [
                                  meetings!.requests!.meetings![index], 
                                  true,
                                  (meetings!.requests!.meetings![index].type == 'online' && (meetings!.requests!.meetings![index].canAgora ?? false))
                                ]
                              );
                              getData();
                            },
                            time: meetings!.requests!.meetings![index].time
                          );
                        }),

                        space(12),
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