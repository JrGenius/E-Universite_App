import 'package:flutter/material.dart';
import 'package:webinar/common/utils/color_utils.dart';
import 'package:webinar/config/colors.dart';

class CategoryModel {
  int? id;
  String? title;
  Color? color;
  String? icon;
  List<CategoryModel>? subCategories;
  int? webinarsCount;
  bool isOpen=false;

  CategoryModel(
      {this.id,
      this.title,
      this.color,
      this.icon,
      this.subCategories,
      this.webinarsCount});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'] != null ? hexToColor(json['color']) : green77();
    icon = json['icon'];
    if (json['sub_categories'] != null) {
      subCategories = <CategoryModel>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(CategoryModel.fromJson(v));
      });
    }
    webinarsCount = json['webinars_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['color'] = color;
    data['icon'] = icon;
    if (subCategories != null) {
      data['sub_categories'] =
          subCategories!.map((v) => v.toJson()).toList();
    }
    data['webinars_count'] = webinarsCount;
    return data;
  }
}
