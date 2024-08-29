import 'package:webinar/app/models/profile_model.dart';

class MeetingTimesModel {
  int? count;
  List<Times>? times;

  MeetingTimesModel({this.count, this.times});

  MeetingTimesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (times != null) {
      data['times'] = times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  int? id;
  String? time;
  bool? canReserve;
  String? description;
  String? meetingType;
  Meeting? meeting;
  var authReservation;

  Times(
      {this.id,
      this.time,
      this.canReserve,
      this.description,
      this.meetingType,
      this.meeting,
      this.authReservation});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    canReserve = json['can_reserve'];
    description = json['description'];
    meetingType = json['meeting_type'];
    meeting = json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null;
    authReservation = json['auth_reservation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['can_reserve'] = canReserve;
    data['description'] = description;
    data['meeting_type'] = meetingType;
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    data['auth_reservation'] = authReservation;
    return data;
  }
}

