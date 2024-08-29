import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/models/user_model.dart';

class MeetingModel {
  Reservations? reservations;
  Reservations? requests;

  MeetingModel({this.reservations, this.requests});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    reservations = json['reservations'] != null
        ? Reservations.fromJson(json['reservations'])
        : null;
    requests = json['requests'] != null
        ? Reservations.fromJson(json['requests'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reservations != null) {
      data['reservations'] = reservations!.toJson();
    }
    if (requests != null) {
      data['requests'] = requests!.toJson();
    }
    return data;
  }
}

class Reservations {
  int? count;
  List<Meetings>? meetings;

  Reservations({this.count, this.meetings});

  Reservations.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['meetings'] != null) {
      meetings = <Meetings>[];
      json['meetings'].forEach((v) {
        meetings!.add(Meetings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (meetings != null) {
      data['meetings'] = meetings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meetings {
  int? id;
  String? status;
  var link;
  String? userPaidAmount;
  var discount;
  String? amount;
  int? date;
  String? day;
  Time? time;
  int? studentCount;
  String? description;
  UserModel? user;
  
  Meeting? meeting;

  String? type;
  bool? canAgora;
  

  Meetings(
      {this.id,
      this.status,
      this.link,
      this.userPaidAmount,
      this.discount,
      this.amount,
      this.date,
      this.day,
      this.time,
      this.studentCount,
      this.description,
      this.meeting,
      this.user});

  Meetings.fromJson(Map<String, dynamic> json) {
    
    type = json['type'];
    canAgora = json['canAgora'];

    id = json['id'];
    status = json['status'];
    link = json['link'];
    userPaidAmount = json['user_paid_amount'];
    discount = json['discount'];
    amount = json['amount'];
    date = json['date'];
    day = json['day'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    studentCount = json['student_count'];
    description = json['description'];
    meeting = json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['link'] = link;
    data['user_paid_amount'] = userPaidAmount;
    data['discount'] = discount;
    data['amount'] = amount;
    data['date'] = date;
    data['day'] = day;
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['student_count'] = studentCount;
    data['description'] = description;
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
