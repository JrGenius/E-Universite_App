
import 'package:flutter/material.dart';
import 'package:webinar/app/models/meeting_times_model.dart';
import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/services/guest_service/providers_service.dart';
import 'package:webinar/app/widgets/main_widget/provider_widget/user_profile_widget.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/enums/meeting_type_enum.dart';
import 'package:webinar/common/utils/currency_utils.dart';
import 'package:webinar/common/utils/date_formater.dart';
import 'package:webinar/config/colors.dart';

import '../../../../../common/utils/app_text.dart';
import '../../../../../config/styles.dart';

class FinalizeDatePage extends StatefulWidget {
  final DateTime date;
  final Times selectedTime;
  final ProfileModel profile;
  const FinalizeDatePage(this.date, this.selectedTime, this.profile,{super.key});

  @override
  State<FinalizeDatePage> createState() => _FinalizeDatePageState();
}

class _FinalizeDatePageState extends State<FinalizeDatePage> {

  MeetingTypes conductionType = MeetingTypes.inPerson;
  bool isIndividual=true;

  int participates = 0;
  double participatesSliderValue = 0.0;

  TextEditingController descController = TextEditingController();
  FocusNode descNode = FocusNode();

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    
    if(widget.profile.meeting?.inPerson == 0){
      conductionType = MeetingTypes.online;
    }
    
    if(widget.profile.meeting?.groupMeeting == 0){
      isIndividual = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Container(
        
        constraints: BoxConstraints(
          minHeight: getSize().height * .2,
          maxHeight: getSize().height * .85,
        ),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space(25),

              Text(
                appText.finalizeReservation,
                style: style20Bold(),
              ),
    
              space(20),
              
              Text(
                appText.selectedTime,
                style: style12Regular().copyWith(color: greyA5),
              ),
            
              space(6),

              Text(
                '${timeStampToDate(widget.date.millisecondsSinceEpoch)} | ${widget.selectedTime.time}',
                style: style16Bold(),
              ),

              space(20),

              // Meeting Details
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
                      appText.meetingDetails,
                      style: style14Bold(),
                    ),

                    space(6),

                    // online Meeting Hourly Rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          appText.onlineMeetingHourlyRate,
                          style: style14Regular().copyWith(color: greyB2),
                        ),

                        Text(
                          CurrencyUtils.calculator(widget.selectedTime.meeting?.priceWithDiscount ?? 0),
                          style: style14Regular().copyWith(color: greyB2),
                        ),

                      ],
                    ),
                    
                    space(6),

                    // in Person Meeting Hourly Rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          appText.inPersonMeetingHourlyRate,
                          style: style14Regular().copyWith(color: greyB2),
                        ),

                        Text(
                          CurrencyUtils.calculator(widget.selectedTime.meeting?.inPersonPriceWithDiscount ?? 0),
                          style: style14Regular().copyWith(color: greyB2),
                        ),

                      ],
                    ),

                    if(widget.selectedTime.meeting?.groupMeeting == 1)...{
                      space(6),

                      Text(
                        appText.instructorConductsGroupMeetings,
                        style: style14Regular().copyWith(color: greyB2),
                      ),
                    }
                  ],
                ),
              ),

              space(18),

              Text(
                appText.conductionType,
                style: style14Regular(),
              ),

              space(5),

              UserProfileWidget.tabView(
                appText.inPerson, appText.online, 
                conductionType == MeetingTypes.inPerson, 
                (value) {

                  if(widget.selectedTime.meeting?.inPerson == 1){
                    
                    conductionType = value ? MeetingTypes.inPerson : MeetingTypes.online;

                    participatesSliderValue = 0.0;
                    participates = conductionType == MeetingTypes.inPerson 
                      ? (widget.selectedTime.meeting?.inPersonGroupMinStudent ?? 0 ) 
                      : (widget.selectedTime.meeting?.onlineGroupMinStudent ?? 0 );
                    
                  }

                  setState(() {});
                }
              ),

              space(16),

              Text(
                appText.meetingType,
                style: style14Regular(),
              ),

              space(5),

              UserProfileWidget.tabView(
                appText.individual, appText.group, 
                isIndividual, 
                (value) {
                  if(widget.selectedTime.meeting?.groupMeeting == 1){
                    isIndividual = value;
                    setState(() {});
                  }
                }
              ),

              space(18),


              if(!isIndividual)...{
                
                Text(
                  appText.participates,
                  style: style14Regular(),
                ),

                // slider
                Center(
                  child: LayoutBuilder(
                    builder: (context, size) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                  
                      
                          var max = conductionType == MeetingTypes.inPerson ? (widget.selectedTime.meeting?.inPersonGroupMaxStudent ?? 0)  : (widget.selectedTime.meeting?.onlineGroupMaxStudent ?? 0);
                          var min = conductionType == MeetingTypes.inPerson ? (widget.selectedTime.meeting?.inPersonGroupMinStudent ?? 0)  : (widget.selectedTime.meeting?.onlineGroupMinStudent ?? 0);
                  
                          var dx = details.globalPosition.dx;
                      
                          var res = ((max) - (min)) * (dx / size.maxWidth) + (min);
                      
                          participatesSliderValue = ((dx) / (size.maxWidth));
                          participates = res.toInt() >= max ? max : res.toInt();
                                        
                      
                          if(participatesSliderValue >= 1.0){
                            participatesSliderValue = 1.0;
                          }
                      
                          setState(() {});
                        },

                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: getSize().width,
                          height: 40,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                      
                              // line
                              Positioned.fill(
                                right: 0,
                                left: 0,
                                child: Center(
                                  child: Container(
                                    width: getSize().width,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: greyF8,
                                      borderRadius: borderRadius(radius: 10),
                                    ),
                                  ),
                                )
                              ),
                      
                              // indecator and counter
                              AnimatedPositionedDirectional(
                                start: (participatesSliderValue * (size.maxWidth)) - (participatesSliderValue > .7 ? 30 : 0),
                                top: 13,
                                
                                duration: const Duration(milliseconds: 150),
                                child: SizedBox(
                                  width: 50,
                                  child: Column(
                                    children: [
                                      
                                      // circle
                                      AnimatedAlign(
                                        duration: const Duration(milliseconds: 300),
                                        alignment: participatesSliderValue < .2 ? AlignmentDirectional.centerStart : AlignmentDirectional.center,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                                      
                                          decoration: BoxDecoration(
                                            color: green77(),
                                            border: Border.all(color: Colors.white,width: 5),
                                            boxShadow: [boxShadow(const Color(0xffABB7D0).withOpacity(.3),y: 3,blur: 10)],
                                            shape: BoxShape.circle
                                          ),
                                        ),
                                      ),
                                      
                                      space(5),
                                                
                                      // counter
                                      Container(
                                        padding: padding(horizontal: 10,vertical:2 ),
                                        decoration: BoxDecoration(
                                          color: greyF8,
                                          borderRadius: borderRadius(),
                                          border: Border.all(color: greyB2)
                                        ),
                                        child: Text(
                                          participates.toString(),
                                          style: style12Regular().copyWith(color: greyB2),
                                        ),
                                      )
                                                
                                    ],
                                  ),
                                )
                              )
                      
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),

                space(30),
                

                // details
                Container(
                  width: getSize().width,
                  padding: padding(horizontal: 16,vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius(),
                    border: Border.all(
                      color: greyE7,
                    )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        appText.groupMeetingDetails,
                        style: style14Bold(),
                      ),

                      space(8),

                      // meeting Hourly Rate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            appText.meetingHourlyRate,
                            style: style14Regular().copyWith(color: greyB2),
                          ),

                          Text(
                            conductionType == MeetingTypes.inPerson
                            ? CurrencyUtils.calculator(widget.selectedTime.meeting?.inPersonGroupAmount ?? 0)
                            : CurrencyUtils.calculator(widget.selectedTime.meeting?.onlineGroupAmount ?? 0),
                            style: style14Regular().copyWith(color: greyB2),
                          ),

                        ],
                      ),

                      space(8),

                      // meeting Hourly Rate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            appText.groupLiveCapacity,
                            style: style14Regular().copyWith(color: greyB2),
                          ),

                          Text(
                            conductionType == MeetingTypes.inPerson
                            ? '${widget.selectedTime.meeting?.inPersonGroupMinStudent} - ${widget.selectedTime.meeting?.inPersonGroupMaxStudent}'
                            : '${widget.selectedTime.meeting?.onlineGroupMinStudent} - ${widget.selectedTime.meeting?.onlineGroupMaxStudent}',
                            style: style14Regular().copyWith(color: greyB2),
                          ),

                        ],
                      ),


                    ],
                  ),
                ),

                space(18),
              },


              Text(
                appText.description,
                style: style14Regular(),
              ),

              space(8),
              
              descriptionInput(descController, descNode, '', isBorder: true, maxLine: 4),

              space(16),

              Center(
                child: button(
                  onTap: () async {
                    
                    setState(() {
                      isLoading = true;
                    });
                    
                    bool res = await ProvidersService.reserveMeeting(
                      widget.selectedTime.id!, 
                      widget.date.toString().split(' ').first.replaceAll('-', '/'), 
                      conductionType == MeetingTypes.inPerson ? 'in_person' : 'online', 
                      isIndividual ? 1 : participates, 
                      descController.text.trim()
                    );
              
                    if(res){
                      backRoute();
                    }
                    
                    setState(() {
                      isLoading = false;
                    });
                  }, 
                  width: getSize().width, 
                  height: 52, 
                  text: appText.reserveMeeting, 
                  bgColor: green77(), 
                  textColor: Colors.white,
                  isLoading: isLoading
                ),
              ),


              space(22),



            ],
          ),
        ),

      )
    );
  }
}