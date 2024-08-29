import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/utils/app_text.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/config/styles.dart';

class Badges{

  static Widget finished(){
    return Container(

      padding: padding(horizontal: 7, vertical: 5),
      
      decoration: BoxDecoration(
        color: greyE7,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.finished,
        style: style10Regular().copyWith(color: greyB2, height: .8),
      ),
    );
  }

  static Widget notConducted(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: blue64().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.finished,
        style: style10Regular().copyWith(color: blue64(), height: .8),
      ),
    );
  }

  static Widget inProgress(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: blue64().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.inProgress,
        style: style10Regular().copyWith(color: blue64(), height: .8),
      ),
    );
  }

  static Widget off(String percent,{bool isRedBg=false}){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: red49.withOpacity( isRedBg ? 1 : .3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        '$percent% ${appText.off}',
        style: style10Regular().copyWith(color: isRedBg ? Colors.white : red49, height: .8),
      ),
    );
  }

  static Widget liveClass(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.liveClass,
        style: style10Regular().copyWith(color: green77(), height: .8),
      ),
    );
  }

  static Widget course(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.course,
        style: style10Regular().copyWith(color: green77(), height: .8),
      ),
    );
  }

  static Widget textClass(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.textClass,
        style: style10Regular().copyWith(color: green77(), height: .8),
      ),
    );
  }

  static Widget featured(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: yellow29.withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.featured,
        style: style10Regular().copyWith(color: yellow29, height: .8),
      ),
    );
  }


  static Widget notSubmitted(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: red49,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.notSubmitted,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget failed(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: red49,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.failed,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  
  static Widget rejected(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: red49,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.rejected,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget passed(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77(),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.passed,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget pending(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: yellow29,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.pending,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  
  static Widget waiting(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: yellow29,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.waiting,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  
  static Widget open(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: yellow29,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.open,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget active(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77(),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.active,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget closed(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: greyE7,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.closed,
        style: style10Regular().copyWith(color: greyB2, height: 1),
      ),
    );
  }
  
  
  static Widget private(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: red49,
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.private,
        style: style10Regular().copyWith(color: Colors.white, height: 1),
      ),
    );
  }
  
  static Widget replied(){
    return Container(

      padding: padding(horizontal: 6, vertical: 5),
      
      decoration: BoxDecoration(
        color: green77().withOpacity(.3),
        borderRadius: borderRadius(radius: 100),
      ),

      child: Text(
        appText.replied,
        style: style10Regular().copyWith(color: green77(), height: 1),
      ),
    );
  }

}