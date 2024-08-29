import 'package:flutter/material.dart';
import 'package:webinar/app/models/profile_model.dart';

import '../models/cart_model.dart';
import '../models/notification_model.dart';

class UserProvider extends ChangeNotifier{

  ProfileModel? profile;
  setProfile(ProfileModel data){
    profile = data;
    notifyListeners();
  }


  int? userPoint;
  setPoint(int data){
    userPoint = data;
    notifyListeners();
  }


  CartModel? cartData;
  setCartData(CartModel? data){
    cartData = data;
    notifyListeners();
  }

  List<NotificationModel> notification = [];
  setNotification(List<NotificationModel> data){
    notification = data;
    notifyListeners();
  }

  

  clearAll(){
    profile = null;
    userPoint = null;
    cartData = null;
    notification.clear();
  }
}