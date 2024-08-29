class CurrencyModel {
  int? id;
  String? currency;
  String? currencyPosition;
  String? currencySeparator;
  var currencyDecimal;
  double? exchangeRate;
  int? order;
  int? createdAt;

  CurrencyModel(
      {this.id,
      this.currency,
      this.currencyPosition,
      this.currencySeparator,
      this.currencyDecimal,
      this.exchangeRate,
      this.order,
      this.createdAt});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    currencyPosition = json['currency_position'];
    currencySeparator = json['currency_separator'];
    currencyDecimal = int.tryParse(json['currency_decimal'].toString());
    exchangeRate = double.parse(json['exchange_rate']?.toString() ?? '1.0');
    order = json['order'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency'] = currency;
    data['currency_position'] = currencyPosition;
    data['currency_separator'] = currencySeparator;
    data['currency_decimal'] = currencyDecimal;
    data['exchange_rate'] = exchangeRate;
    data['order'] = order;
    data['created_at'] = createdAt;
    return data;
  }
}