class MeetingDetailsModel {
  Meeting? meeting;

  MeetingDetailsModel({this.meeting});

  MeetingDetailsModel.fromJson(Map<String, dynamic> json) {
    meeting = json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    return data;
  }
}

class Meeting {
  int? id;
  int? meetingId;
  int? saleId;
  int? meetingTimeId;
  String? day;
  int? date;
  int? startAt;
  int? endAt;
  int? userId;
  String? paidAmount;
  String? meetingType;
  int? studentCount;
  int? discount;
  String? link;
  String? password;
  String? description;
  String? status;
  int? createdAt;
  int? lockedAt;
  int? reservedAt;
  
  bool isAgora=false;
  String? agoraLink;

  Meeting(
      {this.id,
      this.meetingId,
      this.saleId,
      this.meetingTimeId,
      this.day,
      this.date,
      this.startAt,
      this.endAt,
      this.userId,
      this.paidAmount,
      this.meetingType,
      this.studentCount,
      this.discount,
      this.link,
      this.password,
      this.description,
      this.status,
      this.createdAt,
      this.lockedAt,
      this.reservedAt});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    saleId = json['sale_id'];
    meetingTimeId = json['meeting_time_id'];
    day = json['day'];
    date = json['date'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    userId = json['user_id'];
    paidAmount = json['paid_amount'];
    meetingType = json['meeting_type'];
    studentCount = json['student_count'];
    discount = json['discount'];
    link = json['link'];
    password = json['password'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    lockedAt = json['locked_at'];
    reservedAt = json['reserved_at'];
    
    isAgora = json['isAgora'];
    agoraLink = json['agoraLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['meeting_id'] = meetingId;
    data['sale_id'] = saleId;
    data['meeting_time_id'] = meetingTimeId;
    data['day'] = day;
    data['date'] = date;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['user_id'] = userId;
    data['paid_amount'] = paidAmount;
    data['meeting_type'] = meetingType;
    data['student_count'] = studentCount;
    data['discount'] = discount;
    data['link'] = link;
    data['password'] = password;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['locked_at'] = lockedAt;
    data['reserved_at'] = reservedAt;
    return data;
  }
}