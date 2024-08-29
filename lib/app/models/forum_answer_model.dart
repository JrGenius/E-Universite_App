import 'package:webinar/app/models/can_model.dart';
import 'package:webinar/app/models/user_model.dart';

class ForumAnswerModel {
  int? id;
  String? description;
  bool? pin;
  bool? resolved;
  UserModel? user;
  int? createdAt;
  Can? can;

  ForumAnswerModel(
      {this.id,
      this.description,
      this.pin,
      this.resolved,
      this.user,
      this.createdAt,
      this.can});

  ForumAnswerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    pin = json['pin'];
    resolved = json['resolved'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    can = json['can'] != null ? Can.fromJson(json['can']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['pin'] = pin;
    data['resolved'] = resolved;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    if (can != null) {
      data['can'] = can!.toJson();
    }
    return data;
  }
}
