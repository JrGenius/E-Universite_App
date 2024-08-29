class SubscriptionModel {
  List<Subscribes>? subscribes;
  bool? subscribed;
  int? subscribeId;
  String? subscribedTitle;
  int? remainedDownloads;
  int? daysRemained;
  int? dayOfUse;

  SubscriptionModel(
      {this.subscribes,
      this.subscribed,
      this.subscribeId,
      this.subscribedTitle,
      this.remainedDownloads,
      this.daysRemained,
      this.dayOfUse});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    if (json['subscribes'] != null) {
      subscribes = <Subscribes>[];
      json['subscribes'].forEach((v) {
        subscribes!.add(Subscribes.fromJson(v));
      });
    }
    subscribed = json['subscribed'];
    subscribeId = json['subscribe_id'];
    subscribedTitle = json['subscribed_title'];
    remainedDownloads = json['remained_downloads'];
    daysRemained = json['days_remained'];
    dayOfUse = json['dayOfUse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subscribes != null) {
      data['subscribes'] = subscribes!.map((v) => v.toJson()).toList();
    }
    data['subscribed'] = subscribed;
    data['subscribe_id'] = subscribeId;
    data['subscribed_title'] = subscribedTitle;
    data['remained_downloads'] = remainedDownloads;
    data['days_remained'] = daysRemained;
    data['dayOfUse'] = dayOfUse;
    return data;
  }
}

class Subscribes {
  int? id;
  String? title;
  String? description;
  int? usableCount;
  int? days;
  int? price;
  int? isPopular;
  String? image;
  int? createdAt;

  Subscribes(
      {this.id,
      this.title,
      this.description,
      this.usableCount,
      this.days,
      this.price,
      this.isPopular,
      this.image,
      this.createdAt});

  Subscribes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    usableCount = json['usable_count'];
    days = json['days'];
    price = json['price'];
    isPopular = json['is_popular'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['usable_count'] = usableCount;
    data['days'] = days;
    data['price'] = price;
    data['is_popular'] = isPopular;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}