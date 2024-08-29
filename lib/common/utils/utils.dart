

import 'package:flutter/material.dart';
import 'package:webinar/app/models/banks_model.dart';
import 'package:webinar/config/colors.dart';

import '../../locator.dart';
import '../data/app_language.dart';

String checkTitleWithLanguage(List<Translations> data){

  String? title = data.where((element) => element.locale == locator<AppLanguage>().currentLanguage.toLowerCase()).first.title;

  if(title == null){
    return data.where((element) => element.locale == 'en').first.title ?? '';
  }

  return title;
}

Color getColorFromRGBString(String rgbString) {

    if(rgbString.isEmpty){
      return green77();
    }

    // Remove "rgb(" and ")" and split by comma
    List<String> values = rgbString.replaceAll("rgb(", "").replaceAll(")", "").split(",");
    // Parse each value and create a Color object
    int red = int.parse(values[0].trim());
    int green = int.parse(values[1].trim());
    int blue = int.parse(values[2].trim());
    return Color.fromRGBO(red, green, blue, 1.0);
  }