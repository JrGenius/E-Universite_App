class NotificationModel {
  int? id;
  String? title;
  String? message;
  String? type;
  String? status;
  int? createdAt;

  NotificationModel(
      {this.id,
      this.title,
      this.message,
      this.type,
      this.status,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}