import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:webinar/app/models/meeting_times_model.dart';
import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/pages/main_page/providers_page/user_profile_page/finalize_date_page.dart';
import 'package:webinar/app/services/guest_service/providers_service.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

import '../../../../../common/utils/date_formater.dart';

class SelectDatePage extends StatefulWidget {
  final int userId;
  final ProfileModel profile;
  const SelectDatePage(this.userId, this.profile, {super.key});

  @override
  State<SelectDatePage> createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  
  DateTime selectedDate = DateTime.now();

  bool isLoadingGetMeeting = false;
  MeetingTimesModel? meetings;

  Times? selectedTime;


  @override
  void initState() {
    super.initState();

    getMeetings();
  }

  getMeetings() async {

    meetings = null;

    setState(() {
      isLoadingGetMeeting = true;
    });

    meetings = await ProvidersService.getMeetings(widget.userId, selectedDate.millisecondsSinceEpoch);

    setState(() {
      isLoadingGetMeeting = false;
    });
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
                  appText.pickaDate,
                  style: style20Bold(),
                ),
      
                space(20),

                // time count
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      timeStampToDate(selectedDate.millisecondsSinceEpoch),
                      style: style16Bold(),
                    ),

                    space(6),

                    Text(
                      '${meetings?.count ?? '-'} ${appText.meetingTimesAreAvailable}',
                      style: style12Regular().copyWith(color: greyA5),
                    ),

                  ],
                ),

                space(10),

                // calender
                Container(
                  padding: padding(horizontal: 20),
                  width: getSize().width,
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    
                    focusedDay: selectedDate,
                    currentDay: selectedDate,

                    onDaySelected: (selected, focusedDay) {
                      if(selected.difference(DateTime.now()).inDays >= 0){

                        setState(() {
                          selectedTime = null;
                          selectedDate = selected;
                        });

                        getMeetings();
                      }
                    },

                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: style16Bold()
                    ),


                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: green77(),
                        shape: BoxShape.circle,
                      ),

                      selectedDecoration: BoxDecoration(
                        color: green77(),
                        shape: BoxShape.circle,
                      ),
                      
                    ),

                    rowHeight: 45,
                  ),
                ),

                space(20),

                // important
                AnimatedCrossFade(
                  firstChild: SizedBox(width: getSize().width), 
                  secondChild: Column(
                    children: [

                      Container(
                        width: getSize().width,
                        padding: padding(horizontal: 10, vertical: 10),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius(),
                          border: Border.all(color: greyE7),
                        ),
                        
                        child: Row(
                          children: [

                            // icon
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: green77(),
                                shape: BoxShape.circle,
                              ),
                              
                              alignment: Alignment.center,
                              child: SvgPicture.asset(AppAssets.timeCircleSvg, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), width: 20),
                            ),

                            space(0, width: 10),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            
                                  Text(
                                    appText.important,
                                    style: style14Bold(),
                                  ),

                                  space(5),                                  
                                  
                                  Text(
                                    '${appText.timeSlotsDisplayedIn} ${selectedTime?.meeting?.timeZone ?? ''} ${selectedTime?.meeting?.gmt ?? ''} ${appText.timeZone}.',
                                    style: style12Regular().copyWith(color: greyA5),
                                  ),
                            
                                ],
                              ),
                            ),


                            

                          ],
                        ),
                      ),

                      space(24),
                    ],
                  ),
                
                  crossFadeState: selectedTime == null ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                  duration: const Duration(milliseconds: 300)
                ),

                
                Text(
                  appText.pickaTime,
                  style: style20Bold(),
                ),

                space(16),

                // times
                AnimatedCrossFade(
                  firstChild: SizedBox(width: getSize().width), 
                  secondChild: SizedBox(
                    width: getSize().width,
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 12/4, mainAxisSpacing: 16, crossAxisSpacing: 16),
                      children: List.generate(meetings?.times?.length ?? 0, (index) {
                        return GestureDetector(
                          onTap: (){
                            selectedTime = meetings!.times![index];
                            setState(() {});
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedTime == meetings?.times?[index] ? green77() : Colors.white,
                              borderRadius: borderRadius(radius: 10),
                              border: Border.all(
                                color: selectedTime == meetings?.times?[index] ? green77() : greyE7,
                              )
                            ),

                            child: Text(
                              meetings?.times?[index].time ?? '',
                              style: style12Regular().copyWith(color: selectedTime == meetings?.times?[index] ?Colors.white : greyA5),
                            ),

                          ),
                        );
                      }),
                    ),
                  ), 
                  crossFadeState: meetings == null ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                  duration: const Duration(milliseconds: 300)
                ),

                space(16),
                
                button(
                  onTap: (){
                    if(selectedTime != null){
                      backRoute();
                      baseBottomSheet(child: FinalizeDatePage(selectedDate, selectedTime!, widget.profile));
                    }
                  }, 
                  width: getSize().width, 
                  height: 51, 
                  text: appText.finalizeReservation, 
                  bgColor: green77(), 
                  textColor: Colors.white
                ),

                space(30),


              ],
            ),
          ),
      ),
      
    );
  }
}