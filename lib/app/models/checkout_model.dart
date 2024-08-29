import 'cart_model.dart';

class CheckoutModel {
  List<PaymentChannels>? paymentChannels;
  Order? order;
  int? count;
  var userCharge;
  bool? razorpay;
  Amounts? amounts;

  CheckoutModel(
      {this.paymentChannels,
      this.order,
      this.count,
      this.userCharge,
      this.razorpay,
      this.amounts});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentChannels'] != null) {
      paymentChannels = <PaymentChannels>[];
      json['paymentChannels'].forEach((v) {
        paymentChannels!.add(PaymentChannels.fromJson(v));
      });
    }
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    count = json['count'];
    userCharge = json['userCharge'];
    razorpay = json['razorpay'];
    amounts =
        json['amounts'] != null ? Amounts.fromJson(json['amounts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentChannels != null) {
      data['paymentChannels'] =
          paymentChannels!.map((v) => v.toJson()).toList();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    data['count'] = count;
    data['userCharge'] = userCharge;
    data['razorpay'] = razorpay;
    if (amounts != null) {
      data['amounts'] = amounts!.toJson();
    }
    return data;
  }
}

class PaymentChannels {
  int? id;
  String? title;
  String? className;
  String? status;
  String? image;
  String? settings;
  List<String>? currencies;
  String? createdAt;
  String? type = 'online';

  PaymentChannels(
      {this.id,
      this.title,
      this.className,
      this.status,
      this.image,
      this.settings,
      this.currencies,
      this.type,
      this.createdAt});

  PaymentChannels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    className = json['class_name'];
    status = json['status'];
    image = json['image'];
    settings = json['settings'];
    currencies = json['currencies'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['class_name'] = className;
    data['status'] = status;
    data['image'] = image;
    data['settings'] = settings;
    data['currencies'] = currencies;
    data['created_at'] = createdAt;
    return data;
  }
}

class Order {
  int? userId;
  String? status;
  var amount;
  var tax;
  var totalDiscount;
  var totalAmount;
  int? createdAt;
  int? id;

  Order(
      {this.userId,
      this.status,
      this.amount,
      this.tax,
      this.totalDiscount,
      this.totalAmount,
      this.createdAt,
      this.id});

  Order.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    status = json['status'];
    amount = json['amount'];
    tax = json['tax'];
    totalDiscount = json['total_discount'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['status'] = status;
    data['amount'] = amount;
    data['tax'] = tax;
    data['total_discount'] = totalDiscount;
    data['total_amount'] = totalAmount;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
