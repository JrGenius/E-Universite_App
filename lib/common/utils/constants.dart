import 'package:flutter/material.dart';

class Constants {
  static const dommain = 'https://universite.ci';
  static const baseUrl = '$dommain/api/development/';
  static const apiKey = '1234';
  static const scheme = 'E-Universite';

  static final RouteObserver<ModalRoute<void>> singleCourseRouteObserver =
      RouteObserver<ModalRoute<void>>();
  static final RouteObserver<ModalRoute<void>> contentRouteObserver =
      RouteObserver<ModalRoute<void>>();
}
