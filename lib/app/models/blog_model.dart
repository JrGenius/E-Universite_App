import 'package:flutter/material.dart';
import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/user_model.dart';

class BlogModel {
  int? id;
  String? title;
  String? image;
  String? description;
  String? content;
  int? createdAt;
  String? locale;
  UserModel? author;
  int? commentCount;
  List<Comments>? comments;
  String? category;

  List<CustomBadges>? badges;


  BlogModel(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.content,
      this.createdAt,
      this.locale,
      this.author,
      this.commentCount,
      this.comments,
      this.category});

  BlogModel.fromJson(Map<String, dynamic> json) {

    if (json['badges'] != null) {
      badges = <CustomBadges>[];
      json['badges'].forEach((v) {
        badges!.add(CustomBadges.fromJson(v));
      });
    }
    
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    content = json['content'];
    createdAt = json['created_at'];
    locale = json['locale'];
    author =
        json['author'] != null ? UserModel.fromJson(json['author']) : null;
    commentCount = json['comment_count'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['locale'] = locale;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['comment_count'] = commentCount;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    return data;
  }
}

class Comments {
  int? id;
  String? status;
  String? commentUserType;
  int? createAt;
  String? comment;
  Blog? blog;
  CourseModel? webinar;
  UserModel? user;
  List<Replies>? replies;

  GlobalKey globalKey = GlobalKey();

  Comments(
      {this.id,
      this.status,
      this.commentUserType,
      this.createAt,
      this.comment,
      this.blog,
      this.user,
      this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    commentUserType = json['comment_user_type'];
    createAt = json['create_at'];
    comment = json['comment'];
    blog = json['blog'] != null ? Blog.fromJson(json['blog']) : null;
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['comment_user_type'] = commentUserType;
    data['create_at'] = createAt;
    data['comment'] = comment;
    if (blog != null) {
      data['blog'] = blog!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blog {
  int? id;
  String? title;
  String? image;
  String? description;
  int? createdAt;
  UserModel? author;
  int? commentCount;
  String? category;

  Blog(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.createdAt,
      this.author,
      this.commentCount,
      this.category});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    author =
        json['author'] != null ? UserModel.fromJson(json['author']) : null;
    commentCount = json['comment_count'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['comment_count'] = commentCount;
    data['category'] = category;
    return data;
  }
}

class Replies {
  int? id;
  String? commentUserType;
  UserModel? user;
  int? createAt;
  String? comment;

  Replies(
      {this.id, this.commentUserType, this.user, this.createAt, this.comment});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentUserType = json['comment_user_type'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    createAt = json['create_at'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment_user_type'] = commentUserType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['create_at'] = createAt;
    data['comment'] = comment;
    return data;
  }
}
