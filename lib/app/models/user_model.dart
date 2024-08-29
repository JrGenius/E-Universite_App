class UserModel {
  int? id;
  String? fullName;
  String? roleName;
  String? bio;
  String? offline;
  String? offlineMessage;
  String? verified;
  String? rate;
  String? avatar;
  String? meetingStatus;
  String? email;
  UserGroup? userGroup;
  String? address;

  UserModel(
      {this.id,
      this.fullName,
      this.roleName,
      this.bio,
      this.offline,
      this.offlineMessage,
      this.verified,
      this.rate,
      this.avatar,
      this.meetingStatus,
      this.userGroup,
      this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleName = json['role_name'];
    bio = json['bio'];
    offline = json['offline']?.toString();
    email = json['email'];
    offlineMessage = json['offline_message'];
    verified = json['verified']?.toString();
    rate = json['rate']?.toString();
    avatar = json['avatar'];
    meetingStatus = json['meeting_status'];
    userGroup = json['user_group'] != null
        ? UserGroup.fromJson(json['user_group'])
        : null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_name'] = roleName;
    data['bio'] = bio;
    data['offline'] = offline;
    data['offline_message'] = offlineMessage;
    data['verified'] = verified;
    data['rate'] = rate;
    data['avatar'] = avatar;
    data['meeting_status'] = meetingStatus;
    if (userGroup != null) {
      data['user_group'] = userGroup!.toJson();
    }
    data['address'] = address;
    return data;
  }
}

class UserGroup {
  int? id;
  String? name;
  String? status;
  int? commission;
  int? discount;

  UserGroup({this.id, this.name, this.status, this.commission, this.discount});

  UserGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    commission = json['commission'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['commission'] = commission;
    data['discount'] = discount;
    return data;
  }
}