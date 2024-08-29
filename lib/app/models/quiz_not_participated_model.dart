import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/quize_model.dart';
import 'package:webinar/app/models/user_model.dart';

class QuizNotParticipatedModel {
  int? id;
  String? title;
  int? time;
  String? authStatus;
  int? questionCount;
  int? totalMark;
  int? passMark;
  int? averageGrade;
  int? studentCount;
  int? certificatesCount;
  int? successRate;
  String? status;
  int? attempt;
  int? createdAt;
  int? certificate;
  UserModel? teacher;
  int? authAttemptCount;
  String? attemptState;
  bool? authCanStart;
  CourseModel? webinar;
  List<Question>? questions;
  bool? authCanDownloadCertificate;
  int? participatedCount;
  List<UserModel>? latestStudents;

  QuizNotParticipatedModel(
      {this.id,
      this.title,
      this.time,
      this.authStatus,
      this.questionCount,
      this.totalMark,
      this.passMark,
      this.averageGrade,
      this.studentCount,
      this.certificatesCount,
      this.successRate,
      this.status,
      this.attempt,
      this.createdAt,
      this.certificate,
      this.teacher,
      this.authAttemptCount,
      this.attemptState,
      this.authCanStart,
      this.webinar,
      this.questions,
      this.authCanDownloadCertificate,
      this.participatedCount,
      this.latestStudents});

  QuizNotParticipatedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    authStatus = json['auth_status'];
    questionCount = json['question_count'];
    totalMark = json['total_mark'];
    passMark = json['pass_mark'];
    averageGrade = json['average_grade'];
    studentCount = json['student_count'];
    certificatesCount = json['certificates_count'];
    successRate = json['success_rate'];
    status = json['status'];
    attempt = json['attempt'];
    createdAt = json['created_at'];
    certificate = json['certificate'];
    teacher = json['teacher'] != null ? UserModel.fromJson(json['teacher']) : null;
    authAttemptCount = json['auth_attempt_count'];
    attemptState = json['attempt_state'];
    authCanStart = json['auth_can_start'];
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
    authCanDownloadCertificate = json['auth_can_download_certificate'];
    participatedCount = json['participated_count'];
    if (json['latest_students'] != null) {
      latestStudents = <UserModel>[];
      json['latest_students'].forEach((v) {
        latestStudents!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['auth_status'] = authStatus;
    data['question_count'] = questionCount;
    data['total_mark'] = totalMark;
    data['pass_mark'] = passMark;
    data['average_grade'] = averageGrade;
    data['student_count'] = studentCount;
    data['certificates_count'] = certificatesCount;
    data['success_rate'] = successRate;
    data['status'] = status;
    data['attempt'] = attempt;
    data['created_at'] = createdAt;
    data['certificate'] = certificate;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    data['auth_attempt_count'] = authAttemptCount;
    data['attempt_state'] = attemptState;
    data['auth_can_start'] = authCanStart;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['auth_can_download_certificate'] = authCanDownloadCertificate;
    data['participated_count'] = participatedCount;
    if (latestStudents != null) {
      data['latest_students'] =
          latestStudents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
