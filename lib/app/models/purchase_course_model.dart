import 'package:webinar/app/models/course_model.dart';

class PurchaseCourseModel {
  int? id;
  int? sellerId;
  int? buyerId;
  int? orderId;
  int? webinarId;
  int? bundleId;
  int? meetingId;
  int? meetingTimeId;
  int? subscribeId;
  int? ticketId;
  int? promotionId;
  int? productOrderId;
  int? registrationPackageId;
  int? installmentPaymentId;
  int? giftId;
  String? paymentMethod;
  String? type;
  String? amount;
  String? tax;
  String? commission;
  String? discount;
  String? totalAmount;
  int? productDeliveryFee;
  int? manualAdded;
  int? accessToPurchasedItem;
  int? createdAt;
  int? refundAt;
  bool? expired;
  int? expiredAt;
  CourseModel? webinar;
  CourseModel? bundle;

  PurchaseCourseModel(
      {this.id,
      this.sellerId,
      this.buyerId,
      this.orderId,
      this.webinarId,
      this.bundleId,
      this.meetingId,
      this.meetingTimeId,
      this.subscribeId,
      this.ticketId,
      this.promotionId,
      this.productOrderId,
      this.registrationPackageId,
      this.installmentPaymentId,
      this.giftId,
      this.paymentMethod,
      this.type,
      this.amount,
      this.tax,
      this.commission,
      this.discount,
      this.totalAmount,
      this.productDeliveryFee,
      this.manualAdded,
      this.accessToPurchasedItem,
      this.createdAt,
      this.refundAt,
      this.expired,
      this.webinar,
      this.bundle});

  PurchaseCourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    buyerId = json['buyer_id'];
    orderId = json['order_id'];
    webinarId = json['webinar_id'];
    bundleId = json['bundle_id'];
    meetingId = json['meeting_id'];
    meetingTimeId = json['meeting_time_id'];
    subscribeId = json['subscribe_id'];
    ticketId = json['ticket_id'];
    promotionId = json['promotion_id'];
    productOrderId = json['product_order_id'];
    registrationPackageId = json['registration_package_id'];
    installmentPaymentId = json['installment_payment_id'];
    giftId = json['gift_id'];
    paymentMethod = json['payment_method'];
    type = json['type'];
    amount = json['amount'];
    tax = json['tax'];
    commission = json['commission'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    productDeliveryFee = int.tryParse(json['product_delivery_fee']?.toString() ?? '0');
    manualAdded = json['manual_added'];
    accessToPurchasedItem = json['access_to_purchased_item'];
    createdAt = json['created_at'];
    refundAt = json['refund_at'];
    expired = json['expired'];
    expiredAt = json['expired_at'];
    webinar =  json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
    bundle =  json['bundle'] != null ? CourseModel.fromJson(json['bundle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['buyer_id'] = buyerId;
    data['order_id'] = orderId;
    data['webinar_id'] = webinarId;
    data['bundle_id'] = bundleId;
    data['meeting_id'] = meetingId;
    data['meeting_time_id'] = meetingTimeId;
    data['subscribe_id'] = subscribeId;
    data['ticket_id'] = ticketId;
    data['promotion_id'] = promotionId;
    data['product_order_id'] = productOrderId;
    data['registration_package_id'] = registrationPackageId;
    data['installment_payment_id'] = installmentPaymentId;
    data['gift_id'] = giftId;
    data['payment_method'] = paymentMethod;
    data['type'] = type;
    data['amount'] = amount;
    data['tax'] = tax;
    data['commission'] = commission;
    data['discount'] = discount;
    data['total_amount'] = totalAmount;
    data['product_delivery_fee'] = productDeliveryFee;
    data['manual_added'] = manualAdded;
    data['access_to_purchased_item'] = accessToPurchasedItem;
    data['created_at'] = createdAt;
    data['refund_at'] = refundAt;
    data['expired'] = expired;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    data['bundle'] = bundle?.toJson();
    return data;
  }
}
