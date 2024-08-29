
class Can {
  bool? pin;
  bool? resolve;
  bool? update;
  bool? view;

  Can({this.pin, this.resolve, this.update});

  Can.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
    resolve = json['resolve'];
    update = json['update'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pin'] = pin;
    data['resolve'] = resolve;
    data['update'] = update;
    data['view'] = view;
    return data;
  }
}