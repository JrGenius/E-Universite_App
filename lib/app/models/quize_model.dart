import 'package:flutter/material.dart';
import 'package:webinar/app/models/user_model.dart';

import 'course_model.dart';


class QuizModel {
  int? id;
  Quiz? quiz;
  CourseModel? webinar;
  UserModel? user;
  int? usergrade;
  String? status;
  int? createdat;
  bool? authcantryagain;
  int? counttryagain;
  bool? reviewable;
  AnswerSheet? answersheet;
  List<QuizReview?>? quizReview;

  QuizModel({this.id, this.quiz, this.webinar, this.user, this.usergrade, this.status, this.createdat, this.authcantryagain, this.counttryagain, this.reviewable, this.answersheet, this.quizReview}); 

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quiz = json['quiz'] != null ? Quiz?.fromJson(json['quiz']) : null;
    webinar = json['webinar'] != null ? CourseModel?.fromJson(json['webinar']) : null;
    user = json['user'] != null ? UserModel?.fromJson(json['user']) : null;
    usergrade = json['user_grade'];
    status = json['status'];
    createdat = json['created_at'];
    authcantryagain = json['auth_can_try_again'];
    counttryagain = json['count_try_again'];
    reviewable = json['reviewable'];

    if (json['quiz_review'] != null) {
      quizReview = <QuizReview>[];
      json['quiz_review'].forEach((v) {
        quizReview!.add(QuizReview.fromJson(v));
      });
    }
    
    answersheet = json['answer_sheet'] != null ? AnswerSheet?.fromJson(json['answer_sheet']) : null;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quiz'] = quiz!.toJson();
    data['webinar'] = webinar!.toJson();
    data['user'] = user!.toJson();
    data['user_grade'] = usergrade;
    data['status'] = status;
    data['created_at'] = createdat;
    data['auth_can_try_again'] = authcantryagain;
    data['count_try_again'] = counttryagain;
    data['reviewable'] = reviewable;
    data['answer_sheet'] = answersheet?.toJson();
    data['quiz_review'] = quizReview != null 
      ? quizReview!.map((v) => v?.toJson()).toList() 
      : null;
    return data;
  }
}


class Answer {
  int? id;
  String? title;
  int? correct;
  String? image;
  int? createdat;
  int? updatedat;

  bool isSelected = false;

  Answer({this.id, this.title, this.correct, this.image, this.createdat, this.updatedat}); 

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    correct = json['correct'];
    image = json['image'];
    createdat = json['created_at'];
    updatedat = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['correct'] = correct;
    data['image'] = image;
    data['created_at'] = createdat;
    data['updated_at'] = updatedat;
    return data;
  }
}

class AnswerSheet {
  Map<String, UserAnswer?> items = {};
  int attemptNumber = 0;

  AnswerSheet.fromJson(Map<String, dynamic> json) {    
    json.forEach((key, value) {
      if (key == 'attempt_number') {
        attemptNumber = int.tryParse(value.toString()) ?? 0;
      } else {
        items[key] = UserAnswer.fromJson(value);
      }
    });
  }

  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    for (var item in items.entries) {
      data.addAll({
        item.key : item.value?.toJson()
      });
    }

    data.addAll({'attempt_number' : attemptNumber});

    return data;
  }
}

class MultipleCorrectAnswer {
  int? id;
  String? title;
  int? correct;
  String? image;
  int? createdat;
  int? updatedat;

  MultipleCorrectAnswer({this.id, this.title, this.correct, this.image, this.createdat, this.updatedat}); 

  MultipleCorrectAnswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    correct = json['correct'];
    image = json['image'];
    createdat = json['created_at'];
    updatedat = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['correct'] = correct;
    data['image'] = image;
    data['created_at'] = createdat;
    data['updated_at'] = updatedat;
    return data;
  }
}

class Question {
  int? id;
  String? title;
  String? type;
  String? descriptivecorrectanswer;
  String? grade;
  int? createdat;
  List<Answer?>? answers;
  int? updatedat;

  TextEditingController inputController = TextEditingController();
  FocusNode node = FocusNode();
  int? gradeForUser;
  


  Question({this.id, this.title, this.type, this.descriptivecorrectanswer, this.grade, this.createdat, this.answers, this.updatedat}); 

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    descriptivecorrectanswer = json['descriptive_correct_answer'];

    grade = json['grade'];
    gradeForUser = int.tryParse(json['grade']) ?? 0;

    createdat = json['created_at'];

    if ( json['answers'] != null || json['quizzes_questions_answers'] != null ) {
      answers = <Answer>[];
      try{
        json['answers'].forEach((v) {
          answers!.add(Answer.fromJson(v));
        });
      }catch(_){}

      try{
        json['quizzes_questions_answers'].forEach((v) {
          answers!.add(Answer.fromJson(v));
        });
      }catch(_){}
    }
    updatedat = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['descriptive_correct_answer'] = descriptivecorrectanswer;
    data['grade'] = grade;
    data['created_at'] = createdat;
    data['answers'] =answers != null ? answers!.map((v) => v?.toJson()).toList() : null;
    data['updated_at'] = updatedat;
    return data;
  }
}

class Quiz {
  int? id;
  // int? studentCount;
  var avrage;
  String? title;
  int? time;
  String? authstatus;
  int? questioncount;
  int? totalmark;
  int? passmark;
  int? averagegrade;
  int? studentcount;
  int? certificatescount;
  int? successrate;
  String? status;
  int? attempt;
  int? createdat;
  int? certificate;
  UserModel? teacher;
  int? authattemptcount;
  String? attemptstate;
  bool? authcanstart;
  CourseModel? webinar;
  List<Question>? questions;
  bool? authcandownloadcertificate;
  int? participatedcount;
  List<UserModel>? lateststudents;

  Quiz({this.id, this.title, this.time, this.authstatus, this.questioncount, this.totalmark, this.passmark, this.averagegrade, this.studentcount, this.certificatescount, this.successrate, this.status, this.attempt, this.createdat, this.certificate, this.teacher, this.authattemptcount, this.attemptstate, this.authcanstart, this.webinar, this.questions, this.authcandownloadcertificate, this.participatedcount, this.lateststudents}); 

  Quiz.fromJson(Map<String, dynamic> json) {
    avrage = json['avrage'];
    // studentCount = json['studentCount'];
    id = json['id'];
    title = json['title'];
    time = json['time'];
    authstatus = json['auth_status'];
    questioncount = json['question_count'];
    totalmark = json['total_mark'];
    passmark = json['pass_mark'];
    averagegrade = json['average_grade'];
    studentcount = json['student_count'];
    certificatescount = json['certificates_count'];
    successrate = json['success_rate'];
    status = json['status'];
    attempt = json['attempt'];
    createdat = json['created_at'];
    certificate = json['certificate'];
    teacher = json['teacher'] != null ? UserModel?.fromJson(json['teacher']) : null;
    authattemptcount = json['auth_attempt_count'];
    attemptstate = json['attempt_state'];
    authcanstart = json['auth_can_start'];
    webinar = json['webinar'] != null ? CourseModel?.fromJson(json['webinar']) : null;

    if (json['questions'] != null || json['quiz_questions'] != null) {
      questions = <Question>[];

      try{
        json['questions']?.forEach((v) {
          questions!.add(Question.fromJson(v));
        });
      }catch(_){}
      
      try{
        json['quiz_questions']?.forEach((v) {
          questions!.add(Question.fromJson(v));
        });
      }catch(_){}
      
    }
    
    authcandownloadcertificate = json['auth_can_download_certificate'];
    participatedcount = json['participated_count'];
    if (json['latest_students'] != null) {
      lateststudents = <UserModel>[];
      json['latest_students'].forEach((v) {
        lateststudents!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['auth_status'] = authstatus;
    data['question_count'] = questioncount;
    data['total_mark'] = totalmark;
    data['pass_mark'] = passmark;
    data['average_grade'] = averagegrade;
    data['student_count'] = studentcount;
    data['certificates_count'] = certificatescount;
    data['success_rate'] = successrate;
    data['status'] = status;
    data['attempt'] = attempt;
    data['created_at'] = createdat;
    data['certificate'] = certificate;
    data['teacher'] = teacher!.toJson();
    data['auth_attempt_count'] = authattemptcount;
    data['attempt_state'] = attemptstate;
    data['auth_can_start'] = authcanstart;
    data['webinar'] = webinar!.toJson();
    data['questions'] = questions != null ? questions!.map((v) => v.toJson()).toList() : null;
    data['auth_can_download_certificate'] = authcandownloadcertificate;
    data['participated_count'] = participatedcount;
    data['latest_students'] = lateststudents != null ? lateststudents!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

class QuizReview {
  int? id;
  String? title;
  String? type;
  String? descriptivecorrectanswer;
  String? grade;
  int? createdat;
  List<Answer?>? answers;
  int? updatedat;
  UserAnswer? useranswer;
  MultipleCorrectAnswer? multiplecorrectanswer;

  QuizReview({this.id, this.title, this.type, this.descriptivecorrectanswer, this.grade, this.createdat, this.answers, this.updatedat, this.useranswer, this.multiplecorrectanswer}); 

  QuizReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    descriptivecorrectanswer = json['descriptive_correct_answer'];
    grade = json['grade'];
    createdat = json['created_at'];
    if (json['answers'] != null) {
      answers = <Answer>[];
      json['answers'].forEach((v) {
        answers!.add(Answer.fromJson(v));
      });
    }
    updatedat = json['updated_at'];
    useranswer = json['user_answer'] != null ? UserAnswer?.fromJson(json['user_answer']) : null;
    multiplecorrectanswer = json['multiple_correct_answer'] != null ? MultipleCorrectAnswer?.fromJson(json['multiple_correct_answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['descriptive_correct_answer'] = descriptivecorrectanswer;
    data['grade'] = grade;
    data['created_at'] = createdat;
    data['answers'] =answers != null ? answers!.map((v) => v?.toJson()).toList() : null;
    data['updated_at'] = updatedat;
    data['user_answer'] = useranswer!.toJson();
    data['multiple_correct_answer'] = multiplecorrectanswer?.toJson();
    return data;
  }
}

class UserAnswer {
  String? grade;
  bool? status;
  var answer;

  UserAnswer({this.grade, this.status, this.answer}); 

  UserAnswer.fromJson(Map<String, dynamic> json) {
    grade = json['grade']?.toString();
    status = json['status'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['status'] = status;
    data['answer'] = answer;
    return data;
  }
}

