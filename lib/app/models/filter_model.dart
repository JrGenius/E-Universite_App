class FilterModel {
  int? id;
  String? title;
  List<Options>? options;

  FilterModel({this.id, this.title, this.options});

  FilterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? title;
  int? order;

  Options({this.id, this.title, this.order});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    return data;
  }
}