import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webinar/app/pages/main_page/home_page/single_course_page/single_content_page/web_view_page.dart';
import 'package:webinar/app/services/user_service/meeting_service.dart';
import 'package:webinar/app/widgets/main_widget/meetings_widget/meetings_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/data/app_data.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';
import 'package:webinar/locator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../config/assets.dart';
import '../../../../models/meeting_details_model.dart';
import '../../../../models/meeting_model.dart';
import '../../../../widgets/main_widget/home_widget/single_course_widget/single_course_widget.dart';

class MeetingDetailsPage extends StatefulWidget {
  static const String pageName = '/meeting-details';
  const MeetingDetailsPage({super.key});

  @override
  State<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {

  Meetings? meeting;
  MeetingDetailsModel? details;
  bool isConsultant = true;
  bool canCreateAgoraLink = false;

  bool isLoading = false;

  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      meeting = (ModalRoute.of(context)!.settings.arguments as List)[0];
      isConsultant = (ModalRoute.of(context)!.settings.arguments as List)[1];
      canCreateAgoraLink = (ModalRoute.of(context)!.settings.arguments as List)[2];
      print(canCreateAgoraLink);
      
      getData();
    });
    
  }


  getData() async {
    setState(() {
      isLoading = true;
    });
    
    details = await MeetingService.getMeetingDetails(meeting!.id!);
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return directionality(
      child: Scaffold(

        appBar: appbar(title: appText.meetingDetails),

        body: isLoading
      ? loading()
      : Stack(
          children: [
            
            // details
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: padding(),

                child: meeting == null
              ? const SizedBox()
              : Column(
                  children: [

                    space(20),

                    // image
                    Container(
                      width: 142,
                      height: 142,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: details?.meeting?.status == 'pending' || details?.meeting?.status == 'open'
                            ? yellow29
                            : details?.meeting?.status == 'finished'
                              ? green77()
                              : red49,

                          width: 15
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          boxShadow(
                            details?.meeting?.status == 'pending' || details?.meeting?.status == 'open'
                            ? yellow29.withOpacity(.25)
                            : details?.meeting?.status == 'finished'
                              ? green77().withOpacity(.25)
                              : red49.withOpacity(.25), 
                            blur: 30, y: 2
                          )
                        ]
                      ),

                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: borderRadius(radius: 120),
                          child: fadeInImage(
                            meeting?.user?.avatar ?? '', 125, 125
                          ),
                        ),
                      ),
                    ),

                    space(14),

                    Text(
                      meeting?.user?.fullName ?? '',
                      style: style20Bold(),
                    ),

                    space(4),

                    Text(
                      isConsultant ? appText.consultant : appText.reservatore,
                      style: style12Regular().copyWith(color: greyA5),
                    ),

                    space(30),

                    // info
                    Container(
                      padding: padding(),
                      width: getSize().width,
                      child: Wrap(
                        runSpacing: 21,
                        children: [

                          SingleCourseWidget.courseStatus(
                            appText.startDate, 
                            timeStampToDate((meeting?.date ?? 0) * 1000), 
                            AppAssets.calendarSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.startTime, 
                            meeting?.time?.start ?? '-', 
                            AppAssets.tickSquareSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.endTime, 
                            meeting?.time?.start ?? '-', 
                            AppAssets.tickSquareSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.amount, 
                            CurrencyUtils.calculator(double.tryParse(meeting?.amount ?? '0') ?? 0), 
                            AppAssets.walletSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.conductionType, 
                            (details?.meeting?.meetingType ?? '') == 'in_person' ? appText.inPerson : appText.online, 
                            AppAssets.videoSvg,
                            width:(getSize().width * .5) - 42,
                          ),
                          
                          SingleCourseWidget.courseStatus(
                            appText.status, 
                            details?.meeting?.status ?? '', 
                            AppAssets.walletSvg,
                            width:(getSize().width * .5) - 42,
                          ),

                          
                        ],
                      ),
                    ),


                    if(details?.meeting?.description != null)...{
                      space(20),

                      // description
                      Container(
                        width: getSize().width,
                        padding: padding(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyE7),
                          borderRadius: borderRadius()
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              appText.description,
                              style: style14Bold(),
                            ),

                            space(6),

                            Text(
                              details?.meeting?.description ?? '',
                              style: style14Regular().copyWith(color: greyB2),
                            ),
                            

                            if( !(details?.meeting?.isAgora ?? true) && (details?.meeting?.password ?? '').isNotEmpty )...{
                              space(6),

                              Text(
                                '${appText.password}: ${details?.meeting?.password ?? ''}',
                                style: style14Regular().copyWith(color: greyB2),
                              ),
                            },

                          ],
                        ),
                      )
                    
                    },

                    if(isConsultant)...{
                      space(20),

                      // address
                      Container(
                        width: getSize().width,
                        padding: padding(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyE7),
                          borderRadius: borderRadius()
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              appText.address,
                              style: style14Bold(),
                            ),

                            space(6),

                            Text(
                              meeting?.user?.address ?? '',
                              style: style14Regular().copyWith(color: greyB2),
                            )

                          ],
                        ),
                      )
                    
                    },

                    space(140),

                    




                  ],
                ),

              )
            ),


            // button
            AnimatedPositioned(
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

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    if((details?.meeting?.meetingType ?? '') != 'in_person')...{
                      Expanded(
                        child: button(
                          onTap: () async {
                            

                            if(details?.meeting?.status == 'pending' || details?.meeting?.status == 'open'){
                              if(isConsultant && (details?.meeting?.link == null && details?.meeting?.agoraLink == null)){

                                if(canCreateAgoraLink){

                                  bool? res = await MeetingWidget.showCreateLinkSheet(details!.meeting!.id!, details!);
                                  
                                  if(res != null && res){
                                    getData();
                                  }

                                }else{

                                  bool? res = await MeetingWidget.setMeetingInfo(details!.meeting!.id!);

                                  if(res != null && res){
                                    getData();
                                  }
                                }

                              }else{

                                if(details?.meeting?.isAgora ?? false){
                                  
                                  nextRoute(
                                    WebViewPage.pageName,
                                    arguments: [
                                      details?.meeting?.agoraLink, 
                                      appText.meeting,
                                      true,
                                      LoadRequestMethod.get
                                    ]
                                  );
                                }else{
                                  
                                  String token = await AppData.getAccessToken();

                                  Map<String, String> headers = {
                                    "Authorization": "Bearer $token",
                                    "Content-Type" : "application/json", 
                                    'Accept' : 'application/json',
                                    'x-api-key' : Constants.apiKey,
                                    'x-locale' : locator<AppLanguage>().currentLanguage.toLowerCase(),
                                  };

                                  launchUrlString(
                                    details?.meeting?.link ?? '',
                                    webViewConfiguration: WebViewConfiguration(
                                      headers: headers
                                    ),
                                    mode: LaunchMode.externalApplication
                                  );

                                }
                              }
                            }

                          }, 
                          width: getSize().width, 
                          height: 51, 

                          text: details?.meeting?.status == 'finished' 
                            ? appText.finished 
                            : details?.meeting?.status == 'canceled'
                              ? appText.canceled
                              : isConsultant && (details?.meeting?.link == null && details?.meeting?.agoraLink == null)
                                ? appText.createJoinInfo
                                : appText.joinMeeting, 

                          bgColor: (details?.meeting?.status == 'pending' && isConsultant) || details?.meeting?.status == 'open' ? green77() : greyCF, 
                          textColor: Colors.white
                        ),
                      ),
                    },


                    if(details?.meeting?.status == 'pending' || details?.meeting?.status == 'open')...{

                      space(0,width: 16),

                      button(
                        onTap: () async {
                          bool? res = await MeetingWidget.showOptionSheet(isConsultant, details!);

                          if(res != null && res){
                            getData();
                          }
                        }, 
                        width: 52,
                        height: 52, 
                        text: '', 
                        bgColor: Colors.white, 
                        textColor: Colors.white,
                        iconPath: AppAssets.menuCircleSvg,
                        iconColor: green77(),
                        borderColor: green77()
                      ),
                      
                    }
                  
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