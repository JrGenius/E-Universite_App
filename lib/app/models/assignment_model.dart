import 'package:webinar/app/models/user_model.dart';

import 'can_model.dart';

class AssignmentModel {
  int? id;
  String? title;
  String? deadline;
  UserModel? student;
  int? deadlineTime;
  Can? can;
  String? description;
  String? webinarTitle;
  String? webinarImage;
  int? firstSubmission;
  int? lastSubmission;
  int? attempts;
  int? usedAttemptsCount;
  int? grade;
  int? totalGrade;
  int? passGrade;
  int? purchaseDate;
  String? userStatus;
  List<Attachments>? attachments;


  String? status;
  int? minGrade;
  int? avgGrade;
  int? pendingCount;
  int? passedCount;
  int? failedCount;
  int? submissionsCount;

  AssignmentModel(
      {this.id,
      this.title,
      this.deadline,
      this.student,
      this.deadlineTime,
      this.can,
      this.description,
      this.webinarTitle,
      this.webinarImage,
      this.firstSubmission,
      this.lastSubmission,
      this.attempts,
      this.usedAttemptsCount,
      this.grade,
      this.totalGrade,
      this.passGrade,
      this.purchaseDate,
      this.userStatus,
      this.attachments});

  AssignmentModel.fromJson(Map<String, dynamic> json) {

    passGrade = json['pass_grade'];
    status = json['status'];
    minGrade = json['min_grade'];
    avgGrade = json['avg_grade'];
    totalGrade = json['total_grade'];
    pendingCount = json['pending_count'];
    passedCount = json['passed_count'];
    failedCount = json['failed_count'];
    submissionsCount = json['submissions_count'];

    id = json['id'];
    title = json['title'];
    deadline = json['deadline']?.toString();
    student = json['student'] != null ? UserModel.fromJson(json['student']) : null;
    deadlineTime = json['deadline_time'];
    can = json['can'] != null ? Can.fromJson(json['can']) : null;
    description = json['description'];
    webinarTitle = json['webinar_title'];
    webinarImage = json['webinar_image'];
    firstSubmission = json['first_submission'];
    lastSubmission = json['last_submission'];
    attempts = json['attempts'];
    usedAttemptsCount = json['used_attempts_count'];
    grade = json['grade'];
    totalGrade = json['total_grade'];
    passGrade = json['pass_grade'];
    purchaseDate = json['purchase_date'];
    userStatus = json['user_status'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['deadline'] = deadline;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['deadline_time'] = deadlineTime;
    if (can != null) {
      data['can'] = can!.toJson();
    }
    data['description'] = description;
    data['webinar_title'] = webinarTitle;
    data['webinar_image'] = webinarImage;
    data['first_submission'] = firstSubmission;
    data['last_submission'] = lastSubmission;
    data['attempts'] = attempts;
    data['used_attempts_count'] = usedAttemptsCount;
    data['grade'] = grade;
    data['total_grade'] = totalGrade;
    data['pass_grade'] = passGrade;
    data['purchase_date'] = purchaseDate;
    data['user_status'] = userStatus;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Attachments {
  String? url;
  String? title;
  String? size;

  Attachments({this.url, this.title, this.size});

  Attachments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    data['size'] = size;
    return data;
  }
}