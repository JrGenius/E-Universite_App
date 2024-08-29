import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier{
  

  bool isOpenDrawer = false;
  setDrawerState(bool state){
    isOpenDrawer = state;
    notifyListeners();
  }
}