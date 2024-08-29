import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/user_model.dart';

class SaleModel {
  List<Sales>? sales;
  int? studentsCount;
  int? webinarsCount;
  int? meetingsCount;
  String? totalSales;
  String? classSales;
  String? meetingSales;

  SaleModel(
      {this.sales,
      this.studentsCount,
      this.webinarsCount,
      this.meetingsCount,
      this.totalSales,
      this.classSales,
      this.meetingSales});

  SaleModel.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
    studentsCount = json['students_count'];
    webinarsCount = json['webinars_count'];
    meetingsCount = json['meetings_count'];
    totalSales = json['total_sales']?.toString();
    classSales = json['class_sales']?.toString();
    meetingSales = json['meeting_sales']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    data['students_count'] = studentsCount;
    data['webinars_count'] = webinarsCount;
    data['meetings_count'] = meetingsCount;
    data['total_sales'] = totalSales;
    data['class_sales'] = classSales;
    data['meeting_sales'] = meetingSales;
    return data;
  }
}

class Sales {
  UserModel? buyer;
  String? type;
  String? paymentMethod;
  int? createdAt;
  String? amount;
  String? discount;
  String? totalAmount;
  var income;
  CourseModel? webinar;
  var meeting;

  Sales(
      {this.buyer,
      this.type,
      this.paymentMethod,
      this.createdAt,
      this.amount,
      this.discount,
      this.totalAmount,
      this.income,
      this.webinar,
      this.meeting});

  Sales.fromJson(Map<String, dynamic> json) {
    buyer = json['buyer'] != null ? UserModel.fromJson(json['buyer']) : null;
    type = json['type'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    amount = json['amount'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    income = json['income'];
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    meeting = json['meeting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (buyer != null) {
      data['buyer'] = buyer!.toJson();
    }
    data['type'] = type;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['amount'] = amount;
    data['discount'] = discount;
    data['total_amount'] = totalAmount;
    data['income'] = income;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    data['meeting'] = meeting;
    return data;
  }
}
