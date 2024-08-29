import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/assets.dart';
import 'package:webinar/config/styles.dart';
import '../../../../../common/utils/date_formater.dart';
import '../../../../../config/colors.dart';

class SpecialOfferWidget extends StatefulWidget {
  final int toDate;
  final String percent;
  const SpecialOfferWidget(this.toDate,this.percent,{super.key});

  @override
  State<SpecialOfferWidget> createState() => _SpecialOfferWidgetState();
}

class _SpecialOfferWidgetState extends State<SpecialOfferWidget> {

  late Timer timer;
  late Duration time;

  @override
  void initState() {
    super.initState();

    time = DateTime.fromMillisecondsSinceEpoch(widget.toDate * 1000).difference(DateTime.now());

    initTimer();
  }

  initTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (t) { 
      if(t.isActive){
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Container(
        margin: const EdgeInsets.only(top: 30),

        child: Stack(
          clipBehavior: Clip.none,
          children: [
      
            // timer
            Positioned(
              child: Container(
                width: getSize().width,
                height: 65,
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  end: 10
                ),
                decoration: BoxDecoration(
                  borderRadius: borderRadius(radius: 15),
                  border: Border.all(
                    color: greyE7
                  )
                ),
      
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    
                    // special offer
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.specialOfferSvg,width: 28,),
      
                        space(0,width: 6),
      
                        Text(
                          appText.specialOffer,
                          style: style12Bold().copyWith(color: green77()),
                        )
                      ],
                    ),


                    // date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // day
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                              dayHourMinuteSecondFormatted(DateTime.fromMillisecondsSinceEpoch(widget.toDate * 1000).difference(DateTime.now())).split(':').first,
                              style: style16Regular().copyWith(color: green77()),
                            ),

                            space(3),

                            Text(
                              appText.day,
                              style: style10Regular().copyWith(color: greyCF),
                            )
                          ],
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(" : ",style: style16Regular().copyWith(color: green77()))
                        ),

                        
                        // hour
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                              dayHourMinuteSecondFormatted(DateTime.fromMillisecondsSinceEpoch(widget.toDate * 1000).difference(DateTime.now())).split(':')[1],
                              style: style16Regular().copyWith(color: green77()),
                            ),

                            space(3),

                            Text(
                              appText.hr,
                              style: style10Regular().copyWith(color: greyCF),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(" : ",style: style16Regular().copyWith(color: green77())),
                        ),

                        // minute
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                              dayHourMinuteSecondFormatted(DateTime.fromMillisecondsSinceEpoch(widget.toDate * 1000).difference(DateTime.now())).split(':')[2],
                              style: style16Regular().copyWith(color: green77()),
                            ),

                            space(3),

                            Text(
                              appText.min,
                              style: style10Regular().copyWith(color: greyCF),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(" : ",style: style16Regular().copyWith(color: green77())),
                        ),

                        // sec
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                              dayHourMinuteSecondFormatted(DateTime.fromMillisecondsSinceEpoch(widget.toDate * 1000).difference(DateTime.now())).split(':')[3],
                              style: style16Regular().copyWith(color: green77()),
                            ),

                            space(3),

                            Text(
                              appText.sec,
                              style: style10Regular().copyWith(color: greyCF),
                            )
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
      
              )
            ),


            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: padding(horizontal: 12,vertical: 13),
                  decoration: BoxDecoration(
                    color: green77(),
                    borderRadius: borderRadius(radius: 10),
                    boxShadow: [
                      boxShadow(green77().withOpacity(.2), blur: 15, y: 10)
                    ]
                  ),
                  child: Column(
                    children: [
              
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.percent,
                            style: style20Bold().copyWith(color: Colors.white),
                          ),
                          
                          Text(
                            '%',
                            style: style16Bold().copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      
                      Text(
                        'O F F',
                        style: style12Regular().copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            )
      
      
          ],
        ),
      )
    );
  }
}