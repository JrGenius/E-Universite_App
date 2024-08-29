import 'package:flutter/material.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/config/colors.dart';
import 'package:webinar/locator.dart';

TextStyle style48Bold() {
  return TextStyle(
    fontFamily: !locator<AppLanguage>().isRtl() ? 'SF-Pro-Bold' : 'Vazir-Bold',
    color: grey33,
    fontSize: 48
  );
}
TextStyle style24Bold() => style48Bold().copyWith(fontSize: 24);
TextStyle style22Bold() => style48Bold().copyWith(fontSize: 22);
TextStyle style20Bold() => style48Bold().copyWith(fontSize: 20);
TextStyle style16Bold() => style48Bold().copyWith(fontSize: 16);
TextStyle style14Bold() => style48Bold().copyWith(fontSize: 14);
TextStyle style12Bold() => style48Bold().copyWith(fontSize: 12);



TextStyle style16Regular() {
  return TextStyle(
    fontFamily: !locator<AppLanguage>().isRtl() ? 'SF-Pro-Regular' : 'Vazir-Regular',
    color: grey33,
    fontSize: 16
  );
}
TextStyle style14Regular() => style16Regular().copyWith(fontSize: 14);
TextStyle style12Regular() => style16Regular().copyWith(fontSize: 12);
TextStyle style10Regular() => style16Regular().copyWith(fontSize: 10);


