class DashboardModel {
  int? offline;
  int? spentPoints;
  int? totalPoints;
  int? availablePoints;
  String? roleName;
  String? fullName;
  int? financialApproval;
  UnreadNotifications? unreadNotifications;
  List<UnreadNoticeboards>? unreadNoticeboards;
  double? balance;
  bool? canDrawable;
  Badges? badges;
  int? countCartItems;
  int? pendingAppointments;
  int? monthlySalesCount;
  MonthlyChart? monthlyChart;
  int? webinarsCount;
  int? reserveMeetingsCount;
  int? supportsCount;
  int? commentsCount;

  DashboardModel(
      {this.offline,
      this.spentPoints,
      this.totalPoints,
      this.availablePoints,
      this.roleName,
      this.fullName,
      this.financialApproval,
      this.unreadNotifications,
      this.unreadNoticeboards,
      this.balance,
      this.canDrawable,
      this.badges,
      this.countCartItems,
      this.pendingAppointments,
      this.monthlySalesCount,
      this.monthlyChart,
      this.webinarsCount,
      this.reserveMeetingsCount,
      this.supportsCount,
      this.commentsCount});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    offline = json['offline'];
    spentPoints = json['spent_points'];
    totalPoints = json['total_points'];
    availablePoints = json['available_points'];
    roleName = json['role_name'];
    fullName = json['full_name'];
    financialApproval = json['financial_approval'];
    
    unreadNotifications = json['unread_notifications'] != null
        ? UnreadNotifications.fromJson(json['unread_notifications'])
        : null;

    // print(json['unread_notifications']);
    if (json['unread_noticeboards'] != null) {
      unreadNoticeboards = <UnreadNoticeboards>[];
      json['unread_noticeboards'].forEach((v) {
        unreadNoticeboards!.add(UnreadNoticeboards.fromJson(v));
      });
    }
    
    balance = double.parse(json['balance']?.toString() ?? '0.0');

    canDrawable = json['can_drawable'];
    badges = json['badges'] != null ? Badges.fromJson(json['badges']) : null;
    countCartItems = json['count_cart_items'];
    pendingAppointments = json['pendingAppointments'];
    monthlySalesCount = json['monthlySalesCount'];
    monthlyChart = json['monthlyChart'] != null
        ? MonthlyChart.fromJson(json['monthlyChart'])
        : null;
    webinarsCount = json['webinarsCount'];
    reserveMeetingsCount = json['reserveMeetingsCount'];
    supportsCount = json['supportsCount'];
    commentsCount = json['commentsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offline'] = offline;
    data['spent_points'] = spentPoints;
    data['total_points'] = totalPoints;
    data['available_points'] = availablePoints;
    data['role_name'] = roleName;
    data['full_name'] = fullName;
    data['financial_approval'] = financialApproval;
    if (unreadNotifications != null) {
      data['unread_notifications'] = unreadNotifications!.toJson();
    }
    if (unreadNoticeboards != null) {
      data['unread_noticeboards'] =
          unreadNoticeboards!.map((v) => v.toJson()).toList();
    }
    data['balance'] = balance;
    data['can_drawable'] = canDrawable;
    if (badges != null) {
      data['badges'] = badges!.toJson();
    }
    data['count_cart_items'] = countCartItems;
    data['pendingAppointments'] = pendingAppointments;
    data['monthlySalesCount'] = monthlySalesCount;
    if (monthlyChart != null) {
      data['monthlyChart'] = monthlyChart!.toJson();
    }
    data['webinarsCount'] = webinarsCount;
    data['reserveMeetingsCount'] = reserveMeetingsCount;
    data['supportsCount'] = supportsCount;
    data['commentsCount'] = commentsCount;
    return data;
  }
}

class UnreadNotifications {
  int? count;
  List<Notifications>? notifications;

  UnreadNotifications({this.count, this.notifications});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {

    count = json['count'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? userId;
  int? senderId;
  int? groupId;
  int? webinarId;
  String? title;
  String? message;
  String? sender;
  String? type;
  int? createdAt;

  Notifications(
      {this.id,
      this.userId,
      this.senderId,
      this.groupId,
      this.webinarId,
      this.title,
      this.message,
      this.sender,
      this.type,
      this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    groupId = json['group_id'];
    webinarId = json['webinar_id'];
    title = json['title'];
    message = json['message'];
    sender = json['sender'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['sender_id'] = senderId;
    data['group_id'] = groupId;
    data['webinar_id'] = webinarId;
    data['title'] = title;
    data['message'] = message;
    data['sender'] = sender;
    data['type'] = type;
    data['created_at'] = createdAt;
    return data;
  }
}

class UnreadNoticeboards {
  int? id;
  int? organId;
  int? instructorId;
  int? webinarId;
  int? userId;
  String? type;
  String? sender;
  String? title;
  String? message;
  int? createdAt;

  UnreadNoticeboards(
      {this.id,
      this.organId,
      this.instructorId,
      this.webinarId,
      this.userId,
      this.type,
      this.sender,
      this.title,
      this.message,
      this.createdAt});

  UnreadNoticeboards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organId = json['organ_id'];
    instructorId = json['instructor_id'];
    webinarId = json['webinar_id'];
    userId = json['user_id'];
    type = json['type'];
    sender = json['sender'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organ_id'] = organId;
    data['instructor_id'] = instructorId;
    data['webinar_id'] = webinarId;
    data['user_id'] = userId;
    data['type'] = type;
    data['sender'] = sender;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}

class Badges {
  String? nextBadge;
  var percent;
  String? earned;

  Badges({this.nextBadge, this.percent, this.earned});

  Badges.fromJson(Map<String, dynamic> json) {
    nextBadge = json['next_badge'];
    percent = json['percent'];
    earned = json['earned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next_badge'] = nextBadge;
    data['percent'] = percent;
    data['earned'] = earned;
    return data;
  }
}

class MonthlyChart {
  List<String>? months;
  List<int>? data;

  MonthlyChart({this.months, this.data});

  MonthlyChart.fromJson(Map<String, dynamic> json) {
    months = json['months'].cast<String>();
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['months'] = months;
    data['data'] = this.data;
    return data;
  }
}