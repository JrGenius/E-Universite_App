import 'package:webinar/app/models/chat_model.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/user_model.dart';

class SupportModel {
  int? id;
  var department;
  String? status;
  String? type;
  String? title;
  CourseModel? webinar;
  UserModel? user;
  List<ChatModel>? conversations;
  int? createdAt;
  int? updatedAt;

  SupportModel(
    {
      this.id,
      this.department,
      this.status,
      this.type,
      this.title,
      this.webinar,
      this.user,
      this.conversations,
      this.createdAt,
      this.updatedAt
    }
  );

  SupportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    department = json['department'];
    status = json['status'];
    type = json['type'];
    title = json['title'];
    webinar =
        json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['conversations'] != null) {
      conversations = <ChatModel>[];
      json['conversations'].forEach((v) {
        conversations!.add(ChatModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['department'] = department;
    data['status'] = status;
    data['type'] = type;
    data['title'] = title;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (conversations != null) {
      data['conversations'] =
          conversations!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

