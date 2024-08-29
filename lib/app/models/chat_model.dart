import 'package:webinar/app/models/user_model.dart';

class ChatModel {
  int? id;
  UserModel? sender;
  var supporter;
  String? message;
  String? fileTitle;
  String? filePath;
  int? createdAt;

  ChatModel(
      {this.id,
      this.sender,
      this.supporter,
      this.message,
      this.fileTitle,
      this.filePath,
      this.createdAt});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'] != null ? UserModel.fromJson(json['sender']) : null;
    supporter = json['supporter'];
    message = json['message'];
    fileTitle = json['file_title'];
    filePath = json['file_path'] ?? json['attach'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['supporter'] = supporter;
    data['message'] = message;
    data['file_title'] = fileTitle;
    data['file_path'] = filePath;
    data['created_at'] = createdAt;
    return data;
  }
}