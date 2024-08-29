import 'package:webinar/app/models/course_model.dart';

class SummaryModel {
  var balance;
  List<History>? history;

  SummaryModel({this.balance, this.history});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? type;
  String? balanceType;
  CourseModel? webinar;
  var subscribe;
  var promotion;
  var registrationPackage;
  String? description;
  var amount;
  int? createdAt;

  History(
      {this.type,
      this.balanceType,
      this.webinar,
      this.subscribe,
      this.promotion,
      this.registrationPackage,
      this.description,
      this.amount,
      this.createdAt});

  History.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    balanceType = json['balance_type'];
    webinar =
        json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    subscribe = json['subscribe'];
    promotion = json['promotion'];
    registrationPackage = json['registration_package'];
    description = json['description'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['balance_type'] = balanceType;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    data['subscribe'] = subscribe;
    data['promotion'] = promotion;
    data['registration_package'] = registrationPackage;
    data['description'] = description;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    return data;
  }
}



class Sales {
  int? count;
  int? amount;

  Sales({this.count, this.amount});

  Sales.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['amount'] = amount;
    return data;
  }
}

