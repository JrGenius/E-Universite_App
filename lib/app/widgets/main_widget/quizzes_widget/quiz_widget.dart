import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:webinar/config/colors.dart';

import '../../../../common/common.dart';
import '../../../../common/utils/app_text.dart';
import '../../../../config/styles.dart';
import '../../../models/quize_model.dart';


class QuizWidget{

  static Widget timer(double progressValue, Duration? quizTime, int? seconds){
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          
          // progress 
          Positioned.fill(
            child: CircularProgressIndicator(
              color: Colors.white,
              value: progressValue,
              backgroundColor: Colors.white.withOpacity(.3),
              strokeWidth: 9,
                          
            ),
          ),

          // timer
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 300),
                  value: quizTime?.inMinutes ?? 0, 
                  wholeDigits: 2,
                  suffix: ':',
                  textStyle: style16Bold().copyWith(color: Colors.white),
                ),
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 300),
                  value: (seconds ?? 0),
                  
                  wholeDigits: 2,
                  textStyle: style16Bold().copyWith(color: Colors.white),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }

  static Widget questionProgressBar(int currentQuestionIndex, Quiz? quizData){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              appText.question,
              style: style12Regular().copyWith(color: Colors.white),
            ),

            Text(
              '${currentQuestionIndex + 1}/${quizData?.questions?.length ?? '0'}',
              style: style12Regular().copyWith(color: Colors.white),
            )
          ],
        ),

        space(4), 

        // progress
        Container(
          width: getSize().width,
          height: 6.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: borderRadius()
          ),
          alignment: AlignmentDirectional.centerStart,
          
          child: SliderTheme(
            data: SliderThemeData(
              thumbShape: SliderComponentShape.noOverlay,
              trackShape: const CustomSliderTrackShape()
            ),
            child: Slider(
              onChanged: (value) {},
              min: 1,
              max: double.parse(quizData?.questions?.length.toString() ?? '2.0'),
              value: currentQuestionIndex.toDouble() + 1,
              inactiveColor: Colors.transparent,
              activeColor: Colors.white,
            ),
          ),
        )

      ],
    );
  }


  static Widget multiAnswerItem(Answer answer,bool isReview, {UserAnswer? userAnswer}){
    

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: getSize().width,
      height: getSize().width,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: borderRadius(),
        boxShadow: answer.isSelected ? [] : [boxShadow(Colors.black.withOpacity(.03), blur: 15, y: 3)],

        border: isReview
          ? Border.all(
              color: userAnswer == null
                ? Colors.white 
                : (userAnswer.answer.toString() != answer.id.toString())
                  ? Colors.white
                  : (userAnswer.status ?? false) ? green77() : red49,
              width: 2.2
            )
          : Border.all(color: answer.isSelected ? green77() : Colors.white.withOpacity(0), width: 2.2),

        image: answer.image == null 
          ? null 
          : DecorationImage(
              image: NetworkImage(answer.image!,),
              fit: BoxFit.fill,
            )
      ),

      alignment: Alignment.center,

      child: Container(
        
        width: getSize().width,
        height: getSize().width,
        padding: padding(horizontal: 8),

        decoration: BoxDecoration(
          
          borderRadius: borderRadius(),

          gradient: answer.title != null
            ? null
            : LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.black12,
                  Colors.black.withOpacity(0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              ),
        ),
        alignment: Alignment.center,
        
        child: Stack(
          children: [
            

            Center(
              child: Text(
                answer.title ?? '',
                style: style16Regular().copyWith(

                  color: isReview                
                ? userAnswer?.answer?.toString() == answer.id.toString()
                  ? (userAnswer?.status ?? false) ? green77() : red49
                  : answer.image == null
                      ? greyA5
                      : Colors.white
                
                : answer.isSelected
                    ? green77()
                    : answer.image == null
                      ? greyA5
                      : Colors.white
                ),
                textAlign: TextAlign.center,
              ),
            ),

            if(isReview && ((answer.correct ?? 0) == 1))...{
              PositionedDirectional(
                top: 8,
                start: 0,
                child: Container(
                  padding: padding(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: green77(),
                    borderRadius: borderRadius()
                  ),

                  child: Text(
                    appText.correct,
                    style: style10Regular().copyWith(color: Colors.white, height: 1),
                  ),
                )
              )
            }

          ],
        ),

      ),
      
    );
  }




}




class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    
    const trackHeight = .2;

    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 4;
    return Rect.fromLTWH(trackLeft + 2, trackTop, trackWidth, trackHeight);
  }
}