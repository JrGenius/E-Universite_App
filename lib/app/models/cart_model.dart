import 'package:webinar/app/models/profile_model.dart';
import 'package:webinar/app/models/user_model.dart';

class CartModel {
  List<Items>? items;
  Amounts? amounts;
  var totalCashbackAmount;
  UserGroup? userGroup;

  CartModel({this.items, this.amounts});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalCashbackAmount = json['totalCashbackAmount'];
    amounts = json['amounts'] != null ? Amounts.fromJson(json['amounts']) : null;
    userGroup = json['user_group'] != null ? UserGroup.fromJson(json['user_group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (amounts != null) {
      data['amounts'] = amounts!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  String? type;
  String? image;
  String? title;
  String? teacherName;
  String? rate;
  String? day;
  String? timezone;
  int? price;
  int? discount;
  int? quantity;
  Time? time;
  Time? timeUser;

  Items(
      {this.id,
      this.type,
      this.image,
      this.title,
      this.teacherName,
      this.rate,
      this.price,
      this.discount,
      this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    title = json['title'];
    day = json['day'];
    timezone = json['timezone'];
    teacherName = json['teacher_name'];
    rate = json['rate'];
    price = double.parse(json['price']?.toString() ?? '0').toInt();
    discount = json['discount'];
    quantity = json['quantity'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    timeUser = json['time_user'] != null ? Time.fromJson(json['time_user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    data['title'] = title;
    data['teacher_name'] = teacherName;
    data['rate'] = rate;
    data['price'] = price;
    data['discount'] = discount;
    data['quantity'] = quantity;
    data['time_user'] = timeUser;
    return data;
  }
}

class Amounts {
  int? subTotal;
  var totalDiscount;
  String? tax;
  var taxPrice;
  var commission;
  var commissionPrice;
  var total;
  var productDeliveryFee;
  bool? taxIsDifferent;

  Amounts(
      {this.subTotal,
      this.totalDiscount,
      this.tax,
      this.taxPrice,
      this.commission,
      this.commissionPrice,
      this.total,
      this.productDeliveryFee,
      this.taxIsDifferent});

  Amounts.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    totalDiscount = json['total_discount'];
    tax = json['tax'];
    taxPrice = json['tax_price'];
    commission = json['commission'];
    commissionPrice = json['commission_price'];
    total = json['total']?.toInt();
    productDeliveryFee = json['product_delivery_fee'];
    taxIsDifferent = json['tax_is_different'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_total'] = subTotal;
    data['total_discount'] = totalDiscount;
    data['tax'] = tax;
    data['tax_price'] = taxPrice;
    data['commission'] = commission;
    data['commission_price'] = commissionPrice;
    data['total'] = total;
    data['product_delivery_fee'] = productDeliveryFee;
    data['tax_is_different'] = taxIsDifferent;
    return data;
  }
}