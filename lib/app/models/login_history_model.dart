class LoginHistoryModel {
  int? id;
  int? userId;
  String? browser;
  String? device;
  String? os;
  String? ip;
  String? country;
  String? city;
  String? location;
  String? sessionId;
  int? sessionStartAt;
  int? sessionEndAt;
  String? endSessionType;
  int? createdAt;

  LoginHistoryModel(
      {this.id,
      this.userId,
      this.browser,
      this.device,
      this.os,
      this.ip,
      this.country,
      this.city,
      this.location,
      this.sessionId,
      this.sessionStartAt,
      this.sessionEndAt,
      this.endSessionType,
      this.createdAt});

  LoginHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    browser = json['browser'];
    device = json['device'];
    os = json['os'];
    ip = json['ip'];
    country = json['country'];
    city = json['city'];
    location = json['location'];
    sessionId = json['session_id'];
    sessionStartAt = json['session_start_at'];
    sessionEndAt = json['session_end_at'];
    endSessionType = json['end_session_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['browser'] = browser;
    data['device'] = device;
    data['os'] = os;
    data['ip'] = ip;
    data['country'] = country;
    data['city'] = city;
    data['location'] = location;
    data['session_id'] = sessionId;
    data['session_start_at'] = sessionStartAt;
    data['session_end_at'] = sessionEndAt;
    data['end_session_type'] = endSessionType;
    data['created_at'] = createdAt;
    return data;
  }
}