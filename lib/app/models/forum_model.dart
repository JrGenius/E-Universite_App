import 'package:webinar/app/models/can_model.dart';
import 'package:webinar/app/models/user_model.dart';

class ForumModel {
  List<Forums>? forums;
  int? questionsCount;
  int? resolvedCount;
  int? openQuestionsCount;
  int? commentsCount;
  int? activeUsersCount;

  ForumModel(
      {this.forums,
      this.questionsCount,
      this.resolvedCount,
      this.openQuestionsCount,
      this.commentsCount,
      this.activeUsersCount});

  ForumModel.fromJson(Map<String, dynamic> json) {
    if (json['forums'] != null) {
      forums = <Forums>[];
      json['forums'].forEach((v) {
        forums!.add(Forums.fromJson(v));
      });
    }
    questionsCount = json['questions_count'];
    resolvedCount = json['resolved_count'];
    openQuestionsCount = json['open_questions_count'];
    commentsCount = json['comments_count'];
    activeUsersCount = json['active_users_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forums != null) {
      data['forums'] = forums!.map((v) => v.toJson()).toList();
    }
    data['questions_count'] = questionsCount;
    data['resolved_count'] = resolvedCount;
    data['open_questions_count'] = openQuestionsCount;
    data['comments_count'] = commentsCount;
    data['active_users_count'] = activeUsersCount;
    return data;
  }
}

class Forums {
  int? id;
  String? title;
  UserModel? user;
  bool? pin;
  String? description;
  int? answersCount;
  bool? resolved;
  String? attachment;
  Can? can;
  int? createdAt;
  List<String>? activeUsers;
  int? more;
  int? lastActivity;
  LastAnswer? lastAnswer;
  bool isDownload = false;

  Forums(
      {this.id,
      this.title,
      this.user,
      this.pin,
      this.description,
      this.answersCount,
      this.resolved,
      this.attachment,
      this.can,
      this.createdAt,
      this.activeUsers,
      this.more,
      this.lastActivity,
      this.lastAnswer});

  Forums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    pin = json['pin'];
    description = json['description'];
    answersCount = json['answers_count'];
    resolved = json['resolved'];
    attachment = json['attachment'];
    can = json['can'] != null ? Can.fromJson(json['can']) : null;
    createdAt = json['created_at'];
    activeUsers = json['active_users']?.cast<String>();
    more = json['more'];
    lastActivity = json['last_activity'];
    lastAnswer = json['last_answer'] != null
        ? LastAnswer.fromJson(json['last_answer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['pin'] = pin;
    data['description'] = description;
    data['answers_count'] = answersCount;
    data['resolved'] = resolved;
    data['attachment'] = attachment;
    if (can != null) {
      data['can'] = can!.toJson();
    }
    data['created_at'] = createdAt;
    data['active_users'] = activeUsers;
    data['more'] = more;
    data['last_activity'] = lastActivity;
    if (lastAnswer != null) {
      data['last_answer'] = lastAnswer!.toJson();
    }
    return data;
  }
}

class LastAnswer {
  String? description;
  UserModel? user;

  LastAnswer({this.description, this.user});

  LastAnswer.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

