import 'package:flutter/material.dart';
import 'package:webinar/app/pages/main_page/categories_page/categories_page.dart';
import 'package:webinar/app/pages/main_page/home_page/home_page.dart';
import 'package:webinar/common/enums/page_name_enum.dart';

import '../pages/main_page/blog_page/blogs_page.dart';
import '../pages/main_page/classes_page/classes_page.dart';
import '../pages/main_page/providers_page/providers_page.dart';

class PageProvider extends ChangeNotifier{

  PageNames page = PageNames.home;

  Map<PageNames,Widget> pages = {
    PageNames.home : const HomePage(),
    PageNames.categories : const CategoriesPage(),
    PageNames.providers : const ProvidersPage(),
    PageNames.blog : const BlogsPage(),
    PageNames.myClasses : const ClassesPage(),
  };

  setPage(PageNames data,{bool emit=true}){

    page = data;
    if(emit){
      notifyListeners();
    }
  }
}