import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/common/data/app_language.dart';
import 'package:webinar/locator.dart';

class ListQuizModel {
  int? id;
  int? studentCount;
  var avrage;
  int? webinarId;
  int? creatorId;
  int? chapterId;
  int? time;
  int? attempt;
  int? passMark;
  int? certificate;
  String? status;
  int? totalMark;
  int? displayLimitedQuestions;
  int? displayNumberOfQuestions;
  int? displayQuestionsRandomly;
  int? expiryDays;
  int? createdAt;
  int? updatedAt;
  String? title;
  int? questionCount;
  CourseModel? webinar;
  List<Translations>? translations;

  ListQuizModel(
      {this.id,
      this.webinarId,
      this.creatorId,
      this.chapterId,
      this.time,
      this.attempt,
      this.passMark,
      this.certificate,
      this.status,
      this.totalMark,
      this.displayLimitedQuestions,
      this.displayNumberOfQuestions,
      this.displayQuestionsRandomly,
      this.expiryDays,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.translations});

  ListQuizModel.fromJson(Map<String, dynamic> json) {
    webinar =  json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    
    studentCount = json['studentCount'];
    questionCount = json['quiz_questions']?.length;
    avrage = json['avrage'];
    
    id = json['id'];
    webinarId = json['webinar_id'];
    creatorId = json['creator_id'];
    chapterId = json['chapter_id'];
    time = json['time'];
    attempt = json['attempt'];
    passMark = json['pass_mark'];
    certificate = json['certificate'];
    status = json['status'];
    totalMark = json['total_mark'];
    displayLimitedQuestions = json['display_limited_questions'];
    displayNumberOfQuestions = json['display_number_of_questions'];
    displayQuestionsRandomly = json['display_questions_randomly'];
    expiryDays = json['expiry_days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['webinar_id'] = webinarId;
    data['creator_id'] = creatorId;
    data['chapter_id'] = chapterId;
    data['time'] = time;
    data['attempt'] = attempt;
    data['pass_mark'] = passMark;
    data['certificate'] = certificate;
    data['status'] = status;
    data['total_mark'] = totalMark;
    data['display_limited_questions'] = displayLimitedQuestions;
    data['display_number_of_questions'] = displayNumberOfQuestions;
    data['display_questions_randomly'] = displayQuestionsRandomly;
    data['expiry_days'] = expiryDays;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }


  String getTitle(){

    String title = '';
    
    for (Translations element in translations ?? []) {
      if(element.locale == locator<AppLanguage>().currentLanguage){
        title = element.title ?? '';
      }
    }

    if(title.isEmpty){
      for (Translations element in translations ?? []) {
        if(element.locale == 'en'){
          title = element.title ?? '';
        }
      }
    }

    return title;
  }
}
