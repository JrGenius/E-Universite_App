class OfflinePaymentModel {
  int? id;
  int? amount;
  var bank;
  String? referenceNumber;
  String? status;
  int? createdAt;
  String? payDate;
  String? attachment;

  OfflinePaymentModel(
      {this.id,
      this.amount,
      this.bank,
      this.referenceNumber,
      this.status,
      this.createdAt,
      this.payDate,
      this.attachment});

  OfflinePaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    bank = json['bank'];
    referenceNumber = json['reference_number'];
    status = json['status'];
    createdAt = json['created_at'];
    payDate = json['pay_date'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['bank'] = bank;
    data['reference_number'] = referenceNumber;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['pay_date'] = payDate;
    data['attachment'] = attachment;
    return data;
  }
}