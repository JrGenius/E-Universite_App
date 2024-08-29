class BanksModel {
  int? id;
  String? logo;
  int? createdAt;
  String? title;
  List<Specifications>? specifications;
  List<Translations>? translations;

  BanksModel(
      {this.id,
      this.logo,
      this.createdAt,
      this.title,
      this.specifications,
      this.translations});

  BanksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    createdAt = json['created_at'];
    title = json['title'];
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(Specifications.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo'] = logo;
    data['created_at'] = createdAt;
    data['title'] = title;
    if (specifications != null) {
      data['specifications'] =
          specifications!.map((v) => v.toJson()).toList();
    }
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specifications {
  int? id;
  int? offlineBankId;
  String? value;
  String? name;
  List<Translations>? translations;

  Specifications(
      {this.id, this.offlineBankId, this.value, this.name, this.translations});

  Specifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offlineBankId = json['offline_bank_id'];
    value = json['value'];
    name = json['name'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offline_bank_id'] = offlineBankId;
    data['value'] = value;
    data['name'] = name;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  int? offlineBankSpecificationId;
  String? locale;
  String? title;

  Translations(
      {this.id, this.offlineBankSpecificationId, this.locale, this.title});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offlineBankSpecificationId = json['offline_bank_specification_id'];
    locale = json['locale'];
    title = json['title'] ?? json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offline_bank_specification_id'] = offlineBankSpecificationId;
    data['locale'] = locale;
    data['title'] = title;
    return data;
  }
}
