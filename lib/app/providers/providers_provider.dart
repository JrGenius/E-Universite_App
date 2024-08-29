import 'package:flutter/material.dart';
import 'package:webinar/app/models/category_model.dart';

class ProvidersProvider extends ChangeNotifier{


  List<CategoryModel> categorySelected = [];

  bool availableForMeeting=false;
  bool free=false;
  bool discount=false;
  bool downloadable=false;

  String sort = '';


  clearFilter(){
    categorySelected.clear();

    availableForMeeting=false;
    free=false;  
    discount=false;
    downloadable=false;

    sort = '';
  }
}