import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:webinar/app/models/meeting_details_model.dart';
import 'package:webinar/app/services/user_service/meeting_service.dart';

import '../../../../common/common.dart';
import '../../../../common/components.dart';
import '../../../../common/utils/app_text.dart';
import '../../../../config/assets.dart';
import '../../../../config/colors.dart';
import '../../../../config/styles.dart';

class MeetingWidget{

  static Future setMeetingInfo(int meetingId) async {

    TextEditingController urlController = TextEditingController();
    FocusNode urlNode = FocusNode();
    
    TextEditingController passwordController = TextEditingController();
    FocusNode passwordNode = FocusNode();

    bool isLoading = false;

    return await baseBottomSheet(
      child: Builder(
        builder: (context) {
          return Padding(
            padding: padding(),
            child: StatefulBuilder(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    space(20),
          
                    Text(
                      appText.meetingJoinDetails,
                      style: style16Bold(),
                    ),

                    space(20),

                    input(urlController, urlNode, appText.joinURL, isBorder: true,iconPathLeft: AppAssets.profileSvg,),

                    space(12),
                    
                    input(passwordController, passwordNode, appText.passwordOptional, isBorder: true,iconPathLeft: AppAssets.ticketSvg,),

                    space(24),


                    Center(
                      child: button(
                        onTap: () async {
                    
                          if(urlController.text.trim().isNotEmpty){
                            state((){
                              isLoading = true;
                            });
                            
                            bool res = await MeetingService.createLink(meetingId, urlController.text.trim().toEnglishDigit(), passwordController.text.trim().toEnglishDigit());
                    
                            if(res){
                              backRoute(arguments: true);
                            }
                    
                            state((){
                              isLoading = false;
                            });
                          }
                    
                        }, 
                        width: getSize().width,
                        height: 52,
                        text: appText.send, 
                        bgColor: green77(), 
                        textColor: Colors.white,
                        isLoading: isLoading
                      ),
                    ),

                    space(28),

          
                  ],
                );
              }
            ),
          );
        },
      )
    );
  }
  
  static Future<bool?> showOptionSheet(bool isConsultant, MeetingDetailsModel data) async {

    bool isLoading = false;

    return await baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: StatefulBuilder(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                space(25),
      
                Text(
                  appText.meetingOptions,
                  style: style20Bold(),
                ),
      
                space(30),

                // add to calender
                GestureDetector(
                  onTap: (){
                    try{
                                      
                      DateTime start = DateTime(
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.startAt ?? 0) * 1000, isUtc: true).year,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.startAt ?? 0) * 1000, isUtc: true).month,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.startAt ?? 0) * 1000, isUtc: true).day,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.startAt ?? 0) * 1000, isUtc: true).hour,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.startAt ?? 0) * 1000, isUtc: true).minute,
                      );
                      DateTime end = DateTime(
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.endAt ?? 0) * 1000, isUtc: true).year,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.endAt ?? 0) * 1000, isUtc: true).month,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.endAt ?? 0) * 1000, isUtc: true).day,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.endAt ?? 0) * 1000, isUtc: true).hour,
                        DateTime.fromMillisecondsSinceEpoch((data.meeting!.endAt ?? 0) * 1000, isUtc: true).minute,
                      );

                      final Event event = Event(
                        title: appText.meeting,
                        description: data.meeting?.description ?? '',
                        startDate: start,
                        endDate: end,
                        iosParams: const IOSParams(),
                        androidParams: const AndroidParams(),
                      );

                      Add2Calendar.addEvent2Cal(event);

                    }catch(e){}

                    backRoute();

                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
      
                      SvgPicture.asset(AppAssets.calendarEmptySvg),
      
                      space(0,width: 8),
      
                      Text(
                        appText.addToCalendar,
                        style: style16Regular(),
                      ),
      
                    ],
                  ),
                ),
      
                space(24),

                // finish
                GestureDetector(
                  onTap: () async {
                    
                    isLoading = true;
                    state((){});

                    bool res = await MeetingService.finisheMeeting(data.meeting!.id!, isConsultant);

                    isLoading = false;
                    state((){});

                    if(res){
                      backRoute(arguments: true);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
      
                      SvgPicture.asset(AppAssets.tickLineSvg),
      
                      space(0, width: 8),
      
                      Text(
                        appText.finishmeeting,
                        style: style16Regular(),
                      ),
                      

                      if(isLoading)...{
                        space(0,width: 8),

                        loading(color: green77())
                      }
      
                    ],
                  ),
                ),

                space(52),
      
              ],
            );
          }
        ),
      )
    );
  }
  
  static Future<bool?> showCreateLinkSheet(int id, MeetingDetailsModel data) async {

    return await baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: StatefulBuilder(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                space(25),
      
                Text(
                  appText.createALiveSession,
                  style: style20Bold(),
                ),
      
                space(30),

                // in app session
                GestureDetector(
                  onTap: () async {
                    try{
                      bool? res = await showCreateLiveSessionSheet(data);

                      if(res != null && res){
                        backRoute(arguments: true);
                      }
                    }catch(e){}

                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
      
                      SvgPicture.asset(AppAssets.videoLineSvg,colorFilter: ColorFilter.mode(grey3A, BlendMode.srcIn)),
      
                      space(0,width: 8),
      
                      Text(
                        appText.inappSession,
                        style: style16Regular(),
                      ),
      
                    ],
                  ),
                ),
      
                space(24),

                // finish
                GestureDetector(
                  onTap: () async {
                                        
                    bool? res = await MeetingWidget.setMeetingInfo(id);

                    if(res != null && res){
                      backRoute(arguments: true);
                    }

                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
      
                      SvgPicture.asset(AppAssets.moreCircleLineSvg, colorFilter: ColorFilter.mode(grey3A, BlendMode.srcIn)),
      
                      space(0, width: 8),
      
                      Text(
                        appText.customSession,
                        style: style16Regular(),
                      ),
                      

      
                    ],
                  ),
                ),

                space(52),
      
              ],
            );
          }
        ),
      )
    );
  }
  
  static Future<bool?> showCreateLiveSessionSheet(MeetingDetailsModel data) async {

    bool isLoading = false;

    return await baseBottomSheet(
      child: Padding(
        padding: padding(),
        child: StatefulBuilder(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
      
                space(25),
      
                Row(
                  children: [
                    Text(
                      appText.newInappLiveSession,
                      style: style20Bold(),
                    ),
                  ],
                ),
      
                space(30),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: green77().withOpacity(.3),
                    shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,

                  child: SvgPicture.asset(AppAssets.videoSvg, colorFilter: ColorFilter.mode(green77(), BlendMode.srcIn), width: 40,),
                ),

                space(30),

                Text(
                  appText.inappLiveSession,
                  style: style16Bold(),  
                ),

                space(8),

                Text(
                  '${appText.inappLiveSessionQuestion}\n${appText.theMeetingDateIs} ${data.meeting?.day}',
                  style: style12Regular().copyWith(color: greyA5),
                  textAlign: TextAlign.center,
                ),
                
                space(20),

                button(
                  onTap: () async {
                    isLoading = true;
                    state((){});
                    
                    bool? res = await MeetingService.addSession(data.meeting!.id!);

                    if(res){
                      backRoute(arguments: true);
                    }
                    
                    isLoading = false;
                    state((){});
                  }, 
                  width: getSize().width, 
                  height: 51, 
                  text: appText.create, 
                  bgColor: green77(), 
                  textColor: Colors.white,
                  isLoading: isLoading
                ),

                space(20),
      
              ],
            );
          }
        ),
      )
    );
  }


}