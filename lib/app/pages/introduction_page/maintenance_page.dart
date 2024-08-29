import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/common/utils/constants.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class MaintenancePage extends StatefulWidget {
  static const String pageName = '/maintenance';
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => MmaintenancePageState();
}

class MmaintenancePageState extends State<MaintenancePage> {

  var data;


  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = (ModalRoute.of(context)!.settings.arguments);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: appbar(title: appText.webinar,onTapLeftIcon: (){
          exit(0);
        }),
        body: Container(
          width: getSize().width,
          height: getSize().height,
          
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.introBgPng), fit: BoxFit.cover),
          ),

          child: Column(
            children: [

              space(20),
              
              Image.network(
                '${Constants.dommain}${data['image'] ?? ''}',
                width: getSize().width * .7,
              ),


              Text(
                data['title'] ?? '',
                style: style20Bold(),
              ),
              
              Padding(
                padding: padding(),
                child: Text(
                  data['description'] ?? '',
                  style: style16Regular().copyWith(color: grey5E),
                  textAlign: TextAlign.center,
                ),
              ),

              space(20),

              MonthTimer(data['end_date'] ?? ''),

              space(32),

              button(
                onTap: (){
                  launchUrlString(data?['maintenance_button']?['link'] ?? '');
                }, 
                width: getSize().width * .4, 
                height: 52, 
                text: data?['maintenance_button']?['title'] ?? '', 
                bgColor: green77(), 
                textColor: Colors.white,
                raduis: 15
              )

            ],
          ),
        ),
      )
    );
  }
}



class MonthTimer extends StatefulWidget {
  final int date;
  const MonthTimer(this.date,{Key? key} ) : super(key: key);

  @override
  State<MonthTimer> createState() => _MonthTimerState();
}

class _MonthTimerState extends State<MonthTimer> {

  late Timer timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    init();
  }

  init(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(mounted){
        if(timer.isActive){

          seconds = DateTime(DateTime.now().year , DateTime.now().month, DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day, 23,59, 59).difference(DateTime.now()).inSeconds;

          setState(() {});
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSize().width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // days
          Column(
            children: [

              Text(
                dayHourMinuteSecondFormatted(Duration(seconds: seconds)).split(':').first,
                style: style16Regular().copyWith(color: green77()),
              ),

              Text(
                appText.day,
                style: style10Regular().copyWith(color: greyCF),
              )

            ],
          ),

          Text(
            ' : ',
            style: style16Regular().copyWith(color: green77()),
          ),
          
          // Hours
          Column(
            children: [

              Text(
                dayHourMinuteSecondFormatted(Duration(seconds: seconds)).split(':')[1],
                style: style16Regular().copyWith(color: green77()),
              ),

              Text(
                appText.hr,
                style: style10Regular().copyWith(color: greyCF),
              )

            ],
          ),

          Text(
            ' : ',
            style: style16Regular().copyWith(color: green77()),
          ),
          
          // min
          Column(
            children: [

              Text(
                dayHourMinuteSecondFormatted(Duration(seconds: seconds)).split(':')[2],
                style: style16Regular().copyWith(color: green77()),
              ),

              Text(
                appText.min,
                style: style10Regular().copyWith(color: greyCF),
              )

            ],
          ),

          Text(
            ' : ',
            style: style16Regular().copyWith(color: green77()),
          ),
          
          // second
          Column(
            children: [

              Text(
                dayHourMinuteSecondFormatted(Duration(seconds: seconds)).split(':')[3],
                style: style16Regular().copyWith(color: green77()),
              ),

              Text(
                appText.sec,
                style: style10Regular().copyWith(color: greyCF),
              )

            ],
          ),

          
          

          

        ],
      ),
    );
  }


  @override
  void dispose() {
    timer.cancel();  
    super.dispose();
  }

  String dayHourMinuteSecondFormatted(Duration date) {
    return [
      date.inDays,
      date.inHours.remainder(24),
      date.inMinutes.remainder(60),
      date.inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }


}