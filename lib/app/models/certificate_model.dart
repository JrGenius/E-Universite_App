import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/quize_model.dart';
import 'package:webinar/app/models/user_model.dart';

class CertificateModel {
  int? id;
  Quiz? quiz;
  CourseModel? webinar;
  UserModel? user;
  int? userGrade;
  String? status;
  int? createdAt;
  int? date;
  bool? authCanTryAgain;
  int? countTryAgain;
  bool? reviewable;
  AnswerSheet? answerSheet;
  List<QuizReview>? quizReview;
  Certificate? certificate;

  String? link;
  String? webinarTitle;
  int? passMark;
  int? averageGrade;
  int? certificatesCount;


  CertificateModel(
      {this.id,
      this.quiz,
      this.webinar,
      this.user,
      this.userGrade,
      this.status,
      this.createdAt,
      this.authCanTryAgain,
      this.countTryAgain,
      this.reviewable,
      this.answerSheet,
      this.quizReview,
      this.certificate});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    userGrade = json['user_grade'];
    status = json['status'];
    link = json['link'];
    
    webinarTitle = json['webinar_title'];
    passMark = json['pass_mark'];
    averageGrade = json['average_grade'];
    certificatesCount = json['certificates_count'];
    date = json['date'];

    createdAt = json['created_at'];
    authCanTryAgain = json['auth_can_try_again'];
    countTryAgain = json['count_try_again'];
    reviewable = json['reviewable'];
    answerSheet = json['answer_sheet'] != null
        ? AnswerSheet.fromJson(json['answer_sheet'])
        : null;
    if (json['quiz_review'] != null) {
      quizReview = <QuizReview>[];
      json['quiz_review'].forEach((v) {
        quizReview!.add(QuizReview.fromJson(v));
      });
    }
    certificate = json['certificate'] != null
        ? Certificate.fromJson(json['certificate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['user_grade'] = userGrade;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['auth_can_try_again'] = authCanTryAgain;
    data['count_try_again'] = countTryAgain;
    data['reviewable'] = reviewable;
    if (answerSheet != null) {
      data['answer_sheet'] = answerSheet!.toJson();
    }
    if (quizReview != null) {
      data['quiz_review'] = quizReview!.map((v) => v.toJson()).toList();
    }
    if (certificate != null) {
      data['certificate'] = certificate!.toJson();
    }
    return data;
  }
}

class Questions {
  int? id;
  String? title;
  String? type;
  String? descriptiveCorrectAnswer;
  String? grade;
  int? createdAt;
  List<Answer>? answers;
  int? updatedAt;

  Questions(
      {this.id,
      this.title,
      this.type,
      this.descriptiveCorrectAnswer,
      this.grade,
      this.createdAt,
      this.answers,
      this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    descriptiveCorrectAnswer = json['descriptive_correct_answer'];
    grade = json['grade'];
    createdAt = json['created_at'];
    if (json['answers'] != null) {
      answers = <Answer>[];
      json['answers'].forEach((v) {
        answers!.add(Answer.fromJson(v));
      });
    }
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['descriptive_correct_answer'] = descriptiveCorrectAnswer;
    data['grade'] = grade;
    data['created_at'] = createdAt;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Certificate {
  int? id;
  int? userGrade;
  String? file;
  String? link;
  int? createdAt;

  Certificate({this.id, this.userGrade, this.file, this.createdAt});

  Certificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userGrade = json['user_grade'];
    file = json['file'];
    link = json['link'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_grade'] = userGrade;
    data['file'] = file;
    data['link'] = link;
    data['created_at'] = createdAt;
    return data;
  }
}