import 'package:webinar/app/models/course_model.dart';
import 'package:webinar/app/models/single_course_model.dart';
import 'package:webinar/app/models/user_model.dart';

class ProfileModel {
  int accessContent = 1;
  int? id;
  int? organId;
  String? fullName;
  String? roleName;
  String? bio;
  int? offline;
  String? offlineMessage;
  int? verified;
  String? rate;
  String? avatar;
  String? meetingStatus;
  UserGroup? userGroup;
  String? address;
  String? status;
  String? email;
  String? mobile;
  String? timezone;
  String? language;
  bool? newsletter;
  int? publicMessage;
  var activeSubscription;
  var headline;
  int? coursesCount;
  int? reviewsCount;
  int? appointmentsCount;
  int? studentsCount;
  int? followersCount;
  int? followingCount;
  List<Badge>? badges;
  List<UserModel>? students;
  bool? authUserIsFollower;
  List<String>? education;
  List<String>? experience;
  List<String>? occupations;
  String? about;
  List<CourseModel>? webinars;
  Meeting? meeting;
  List<UserModel>? organizationTeachers;
  int? countryId;
  int? provinceId;
  int? cityId;
  int? districtId;
  String? accountType;
  String? iban;
  String? accountId;
  String? identityScan;
  String? certificate;

  List<CashbackRules> cashbackRules = [];


  ProfileModel(
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
      this.address,
      this.status,
      this.email,
      this.mobile,
      this.language,
      this.newsletter,
      this.publicMessage,
      this.activeSubscription,
      this.headline,
      this.coursesCount,
      this.reviewsCount,
      this.appointmentsCount,
      this.studentsCount,
      this.followersCount,
      this.followingCount,
      this.badges,
      this.students,
      this.authUserIsFollower,
      this.education,
      this.experience,
      this.occupations,
      this.about,
      this.webinars,
      this.meeting,
      this.organizationTeachers,
      this.countryId,
      this.provinceId,
      this.cityId,
      this.districtId,
      this.accountType,
      this.iban,
      this.accountId,
      this.identityScan,
      this.certificate});

  ProfileModel.fromJson(Map<String, dynamic> json, {var cashback}) {

    if(cashback != null){
      cashbackRules = <CashbackRules>[];
      cashback.forEach((v) {
        cashbackRules.add(CashbackRules.fromJson(v));
      });
    }

    accessContent = json['access_content'] ?? 1;

    organId = json['organ_id'];
    id = json['id'];
    fullName = json['full_name'];
    roleName = json['role_name'];
    bio = json['bio'];
    offline = json['offline'];
    offlineMessage = json['offline_message'];
    verified = json['verified'];
    rate = json['rate']?.toString();
    avatar = json['avatar'];
    meetingStatus = json['meeting_status'];
    userGroup = json['user_group'] != null
        ? UserGroup.fromJson(json['user_group'])
        : null;
    address = json['address'];
    status = json['status'];
    email = json['email'];
    mobile = json['mobile'];
    language = json['language'];
    newsletter = json['newsletter'];
    publicMessage = json['public_message'];
    activeSubscription = json['active_subscription'];
    headline = json['headline'];
    coursesCount = json['courses_count'];
    reviewsCount = json['reviews_count'];
    appointmentsCount = json['appointments_count'];
    studentsCount = json['students_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    if (json['badges'] != null) {
      badges = <Badge>[];
      json['badges'].forEach((v) {
        badges!.add(Badge.fromJson(v));
      });
    }
    if (json['students'] != null) {
      students = <UserModel>[];
      json['students'].forEach((v) {
        students!.add(UserModel.fromJson(v));
      });
    }
    authUserIsFollower = json['auth_user_is_follower'];
    education = json['education'].cast<String>();
    experience = json['experience'].cast<String>();
    occupations = json['occupations'].cast<String>();
    about = json['about'];
    if (json['webinars'] != null) {
      webinars = <CourseModel>[];
      json['webinars'].forEach((v) {
        webinars!.add(CourseModel.fromJson(v));
      });
    }
    meeting =
        json['meeting'] != null ? Meeting.fromJson(json['meeting']) : null;
    if (json['organization_teachers'] != null) {
      organizationTeachers = <UserModel>[];
      json['organization_teachers'].forEach((v) {
        organizationTeachers!.add(UserModel.fromJson(v));
      });
    }
    countryId = json['country_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    accountType = json['account_type'];
    iban = json['iban'];
    accountId = json['account_id'];
    identityScan = json['identity_scan'];
    certificate = json['certificate'];
    timezone = json['timezone'];
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
    data['status'] = status;
    data['email'] = email;
    data['mobile'] = mobile;
    data['language'] = language;
    data['newsletter'] = newsletter;
    data['public_message'] = publicMessage;
    data['active_subscription'] = activeSubscription;
    data['headline'] = headline;
    data['courses_count'] = coursesCount;
    data['reviews_count'] = reviewsCount;
    data['appointments_count'] = appointmentsCount;
    data['students_count'] = studentsCount;
    data['followers_count'] = followersCount;
    data['following_count'] = followingCount;
    if (badges != null) {
      data['badges'] = badges!.map((v) => v.toJson()).toList();
    }
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    data['auth_user_is_follower'] = authUserIsFollower;
    data['education'] = education;
    data['experience'] = experience;
    data['occupations'] = occupations;
    data['about'] = about;
    if (webinars != null) {
      data['webinars'] = webinars!.map((v) => v.toJson()).toList();
    }
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    if (organizationTeachers != null) {
      data['organization_teachers'] =
          organizationTeachers!.map((v) => v.toJson()).toList();
    }
    data['country_id'] = countryId;
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    data['district_id'] = districtId;
    data['account_type'] = accountType;
    data['iban'] = iban;
    data['account_id'] = accountId;
    data['identity_scan'] = identityScan;
    data['certificate'] = certificate;
    return data;
  }
}


class Badge {
  int? id;
  String? title;
  String? type;
  String? condition;
  String? image;
  String? locale;
  String? description;
  int? createdAt;

  Badge(
      {this.id,
      this.title,
      this.type,
      this.condition,
      this.image,
      this.locale,
      this.description,
      this.createdAt});

  Badge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    condition = json['condition'];
    image = json['image'];
    locale = json['locale'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['condition'] = condition;
    data['image'] = image;
    data['locale'] = locale;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}

class Sales {
  int? count;
  int? amount;

  Sales({this.count, this.amount});

  Sales.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['amount'] = amount;
    return data;
  }
}


class Meeting {
  String? timeZone;
  String? gmt;
  int? id;
  int? disabled;
  int? discount;
  int? price;
  int? priceWithDiscount;
  int? inPerson;
  int? inPersonPrice;
  int? inPersonPriceWithDiscount;
  int? inPersonGroupMinStudent;
  int? inPersonGroupMaxStudent;
  int? inPersonGroupAmount;
  int? groupMeeting;
  int? onlineGroupMinStudent;
  int? onlineGroupMaxStudent;
  int? onlineGroupAmount;
  List<DayModel>? timing;
  TimingGroupByDay? timingGroupByDay;
  
  // Time? time;
  // UserModel? user;
  // String? date;
  // String? link;
  // String? day;
  // String? description;
  // int? studentCount;

  Meeting(
      {this.timeZone,
      this.gmt,
      this.id,
      this.disabled,
      this.discount,
      this.price,
      this.priceWithDiscount,
      this.inPerson,
      this.inPersonPrice,
      this.inPersonPriceWithDiscount,
      this.inPersonGroupMinStudent,
      this.inPersonGroupMaxStudent,
      this.inPersonGroupAmount,
      this.groupMeeting,
      this.onlineGroupMinStudent,
      this.onlineGroupMaxStudent,
      this.onlineGroupAmount,
      this.timing,
      this.timingGroupByDay});

  Meeting.fromJson(Map<String, dynamic> json) {
    timeZone = json['time_zone'];
    gmt = json['gmt'];
    // date = json['date'];
    // link = json['link'];
    // day = json['day'];
    // studentCount = json['student_count'];
    // description = json['description'];

    id = json['id'];
    disabled = json['disabled'];
    discount = json['discount']?.toInt();
    price = json['price']?.toInt();
    priceWithDiscount = json['price_with_discount']?.toInt();
    inPerson = json['in_person']?.toInt();
    inPersonPrice = json['in_person_price']?.toInt();
    inPersonPriceWithDiscount = json['in_person_price_with_discount']?.toInt();
    inPersonGroupMinStudent = json['in_person_group_min_student']?.toInt();
    inPersonGroupMaxStudent = json['in_person_group_max_student']?.toInt();
    inPersonGroupAmount = json['in_person_group_amount ']?.toInt();
    groupMeeting = json['group_meeting'];
    onlineGroupMinStudent = json['online_group_min_student'];
    onlineGroupMaxStudent = json['online_group_max_student'];
    onlineGroupAmount = json['online_group_amount']?.toInt();
    if (json['timing'] != null) {
      timing = <DayModel>[];
      json['timing'].forEach((v) {
        timing!.add(DayModel.fromJson(v));
      });
    }

    // time = json['time'] != null ? Time.fromJson(json['time']) : null;
    // user = json['user'] != null ? UserModel.fromJson(json['user']) : null;

    timingGroupByDay = json['timing_group_by_day'] != null
        ? TimingGroupByDay.fromJson(json['timing_group_by_day'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // if (time != null) {
    //   data['time'] = time!.toJson();
    // }
    
    // if (user != null) {
    //   data['user'] = user!.toJson();
    // }

    data['time_zone'] = timeZone;
    data['gmt'] = gmt;
    data['id'] = id;
    data['disabled'] = disabled;
    data['discount'] = discount;
    data['price'] = price;
    data['price_with_discount'] = priceWithDiscount;
    data['in_person'] = inPerson;
    data['in_person_price'] = inPersonPrice;
    data['in_person_price_with_discount'] = inPersonPriceWithDiscount;
    data['in_person_group_min_student'] = inPersonGroupMinStudent;
    data['in_person_group_max_student'] = inPersonGroupMaxStudent;
    data['in_person_group_amount '] = inPersonGroupAmount;
    data['group_meeting'] = groupMeeting;
    data['online_group_min_student'] = onlineGroupMinStudent;
    data['online_group_max_student'] = onlineGroupMaxStudent;
    data['online_group_amount'] = onlineGroupAmount;
    if (timing != null) {
      data['timing'] = timing!.map((v) => v.toJson()).toList();
    }
    if (timingGroupByDay != null) {
      data['timing_group_by_day'] = timingGroupByDay!.toJson();
    }
    return data;
  }
}

class TimingGroupByDay {
  List<DayModel>? saturday;
  List<DayModel>? sunday;
  List<DayModel>? monday;
  List<DayModel>? tuesday;
  List<DayModel>? wednesday;
  List<DayModel>? thursday;
  List<DayModel>? friday;

  TimingGroupByDay(
      {this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday});

  TimingGroupByDay.fromJson(Map<String, dynamic> json) {
    if (json['saturday'] != null) {
      saturday = <DayModel>[];
      json['saturday'].forEach((v) {
        saturday!.add(DayModel.fromJson(v));
      });
    }
    if (json['sunday'] != null) {
      sunday = <DayModel>[];
      json['sunday'].forEach((v) {
        sunday!.add(DayModel.fromJson(v));
      });
    }
    if (json['monday'] != null) {
      monday = <DayModel>[];
      json['monday'].forEach((v) {
        monday!.add(DayModel.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      tuesday = <DayModel>[];
      json['tuesday'].forEach((v) {
        tuesday!.add(DayModel.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      wednesday = <DayModel>[];
      json['wednesday'].forEach((v) {
        wednesday!.add(DayModel.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      thursday = <DayModel>[];
      json['thursday'].forEach((v) {
        thursday!.add(DayModel.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      friday = <DayModel>[];
      json['friday'].forEach((v) {
        friday!.add(DayModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saturday != null) {
      data['saturday'] = saturday!.map((v) => v.toJson()).toList();
    }
    if (sunday != null) {
      data['sunday'] = sunday!.map((v) => v.toJson()).toList();
    }
    if (monday != null) {
      data['monday'] = monday!.map((v) => v.toJson()).toList();
    }
    if (tuesday != null) {
      data['tuesday'] = tuesday!.map((v) => v.toJson()).toList();
    }
    if (wednesday != null) {
      data['wednesday'] = wednesday!.map((v) => v.toJson()).toList();
    }
    if (thursday != null) {
      data['thursday'] = thursday!.map((v) => v.toJson()).toList();
    }
    if (friday != null) {
      data['friday'] = friday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayModel {
  int? id;
  String? dayLabel;
  String? time;

  DayModel({this.id, this.dayLabel, this.time});

  DayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayLabel = json['day_label'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day_label'] = dayLabel;
    data['time'] = time;
    return data;
  }
}

class Time {
  String? start;
  String? end;

  Time({this.start, this.end});

  Time.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}