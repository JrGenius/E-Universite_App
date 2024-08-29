import 'package:webinar/app/models/course_model.dart';

class FavoriteModel {
  int? id;
  CourseModel? webinar;
  int? createdAt;

  FavoriteModel({this.id, this.webinar, this.createdAt});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

