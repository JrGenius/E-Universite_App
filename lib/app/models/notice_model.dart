import 'package:webinar/app/models/user_model.dart';

class NoticeModel {
  int? id;
  String? title;
  String? message;
  String? color;
  int? createdAt;
  String? icon;
  UserModel? creator;

  NoticeModel(
      {this.id,
      this.title,
      this.message,
      this.color,
      this.createdAt,
      this.icon,
      this.creator});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    color = json['color'];
    createdAt = json['created_at'];
    icon = json['icon'];
    creator =
        json['creator'] != null ? UserModel.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['color'] = color;
    data['created_at'] = createdAt;
    data['icon'] = icon;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    return data;
  }
}
