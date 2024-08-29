
import 'package:flutter/widgets.dart';
import 'package:webinar/app/models/course_model.dart';
import '../enums/course_enum.dart';

class CourseUtils{

  static CourseType checkType(CourseModel course){

    switch (course.type) {
      case 'webinar':
        return CourseType.live;

      case 'course':
        return CourseType.video;

      case 'text_lesson':
        return CourseType.text;
        
      default:
        return CourseType.video; 
    }
    
  }
}

extension GlobalKeyExtension on GlobalKey {
  double? get findWidget {
    // final renderObject = currentContext?.findRenderObject();
    // final translation = renderObject?.getTransformTo(null).getTranslation();
    // if (translation != null && renderObject?.paintBounds != null) {
    //   final offset = Offset(translation.x, translation.y);
    //   return renderObject!.paintBounds.shift(offset);
    // } else {
    //   return null;
    // }

    RenderBox box = currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;
    return y;
  }
}