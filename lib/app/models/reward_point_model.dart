import 'package:webinar/app/models/user_model.dart';

class RewardPointModel {
  LeaderBoard? leaderBoard;
  int? availablePoints;
  int? totalPoints;
  int? spentPoints;
  List<Rewards>? rewards;

  RewardPointModel(
      {this.leaderBoard,
      this.availablePoints,
      this.totalPoints,
      this.spentPoints,
      this.rewards});

  RewardPointModel.fromJson(Map<String, dynamic> json) {
    leaderBoard = json['leader_board'] != null
        ? LeaderBoard.fromJson(json['leader_board'])
        : null;
    availablePoints = json['available_points'];
    totalPoints = json['total_points'];
    spentPoints = json['spent_points'];
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(Rewards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaderBoard != null) {
      data['leader_board'] = leaderBoard!.toJson();
    }
    data['available_points'] = availablePoints;
    data['total_points'] = totalPoints;
    data['spent_points'] = spentPoints;
    if (rewards != null) {
      data['rewards'] = rewards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaderBoard {
  int? id;
  UserModel? user;
  int? itemId;
  String? type;
  int? score;
  String? status;
  int? createdAt;
  String? totalPoints;

  LeaderBoard(
      {this.id,
      this.user,
      this.itemId,
      this.type,
      this.score,
      this.status,
      this.createdAt,
      this.totalPoints});

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    itemId = json['item_id'];
    type = json['type'];
    score = json['score'];
    status = json['status'];
    createdAt = json['created_at'];
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['item_id'] = itemId;
    data['type'] = type;
    data['score'] = score;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['total_points'] = totalPoints;
    return data;
  }
}

class Rewards {
  int? id;
  UserModel? user;
  var itemId;
  String? type;
  int? score;
  String? status;
  int? createdAt;

  Rewards(
      {this.id,
      this.user,
      this.itemId,
      this.type,
      this.score,
      this.status,
      this.createdAt});

  Rewards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    itemId = json['item_id'];
    type = json['type'];
    score = json['score'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['item_id'] = itemId;
    data['type'] = type;
    data['score'] = score;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}