class LocationModel {
  int? id;
  int? countryId;
  int? provinceId;
  int? cityId;
  var geoCenter;
  String? type;
  String? title;
  int? createdAt;

  LocationModel(
    {
      this.id,
      this.countryId,
      this.provinceId,
      this.cityId,
      this.geoCenter,
      this.type,
      this.title,
      this.createdAt
     }
  );

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    geoCenter = json['geo_center'];
    type = json['type'];
    title = json['title'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    data['geo_center'] = geoCenter;
    data['type'] = type;
    data['title'] = title;
    data['created_at'] = createdAt;
    return data;
  }
}