import 'package:webinar/app/models/blog_model.dart';
import 'package:webinar/app/models/can_model.dart';
import 'package:webinar/app/models/user_model.dart';

import 'course_model.dart';

class SingleCourseModel {

  int? forum;
  int? isPrivate;

  String? image;
  bool? auth;
  Can? can;
  var canViewError;
  int? id;
  String? status;
  String? label;
  String? title;
  String? type;
  String? link;
  int? accessDays;
  int? salesCountNumber;
  String? liveWebinarStatus;
  bool? authHasBought;
  Sales? sales;
  bool? isFavorite;
  String? priceString;
  String? bestTicketString;
  var price;
  var tax;
  var taxWithDiscount;
  var bestTicketPrice;
  var discountPercent;
  int? coursePageTax;
  var priceWithDiscount;
  var discountAmount;
  int? duration;
  UserModel? teacher;
  int? studentsCount;
  String? rate;
  RateType? rateType;
  int? createdAt;
  int? startDate;
  int? purchasedAt;
  int? reviewsCount;
  ActiveSpecialOffer? activeSpecialOffer;
  int? points;
  var progress;
  var progressPercent;
  String? category;
  int? capacity;
  bool? support;
  bool? subscribe;
  String? description;
  List<Faqs>? faqs;
  List<Comments> comments = [];

  List<BuyTicketsModel> tickets = [];
  List<CertificateModel> certificates = [];
  List<QuizzesModel> quizzes = [];
  List<PrerequisitesModel> prerequisites = [];

  List<SessionChapters> sessionChapters = [];
  List<TextLessonChapters> textLessonChapters = [];
  List<FilesChapters> filesChapters = [];
  List<ReviewModel>? reviews;
  
  int? filesCount;
  int? sessionsCount;
  int? textLessonsCount;
  int? quizzesCount;

  String? videoDemo;
  String? videoDemoSource;
  String? imageCover;
  bool? isDownloadable;
  bool? teacherIsOffline;
  List<Tags>? tags;
  bool? authHasSubscription;
  var canAddToCart;
  bool? canBuyWithPoints;

  List<CashbackRules> cashbackRules = [];



  SingleCourseModel(
      {this.image,
      this.auth,
      this.can,
      this.canViewError,
      this.id,
      this.status,
      this.label,
      this.title,
      this.type,
      this.link,
      this.accessDays,
      this.liveWebinarStatus,
      this.authHasBought,
      this.sales,
      this.isFavorite,
      this.priceString,
      this.bestTicketString,
      this.price,
      this.tax,
      this.taxWithDiscount,
      this.bestTicketPrice,
      this.discountPercent,
      this.coursePageTax,
      this.priceWithDiscount,
      this.discountAmount,
      this.activeSpecialOffer,
      this.duration,
      this.teacher,
      this.studentsCount,
      this.rate,
      this.rateType,
      this.createdAt,
      this.startDate,
      this.purchasedAt,
      this.reviewsCount,
      this.points,
      this.progress,
      this.progressPercent,
      this.category,
      this.capacity,
      this.support,
      this.subscribe,
      this.description,
      this.faqs,
      this.sessionsCount,
      this.filesCount,
      this.textLessonsCount,
      this.quizzesCount,
      this.reviews,
      this.videoDemo,
      this.videoDemoSource,
      this.imageCover,
      this.isDownloadable,
      this.teacherIsOffline,
      this.tags,
      this.authHasSubscription,
      this.canAddToCart,
      this.canBuyWithPoints});

  SingleCourseModel.fromJson(Map<String, dynamic> json) {

    if (json['cashbackRules'] != null) {
      cashbackRules = <CashbackRules>[];
      json['cashbackRules'].forEach((v) {
        cashbackRules.add(CashbackRules.fromJson(v));
      });
    }

    salesCountNumber = json['sales_count_number'];
    isPrivate = json['isPrivate'];
    forum = json['forum'];

    image = json['image'];
    auth = json['auth'];
    can = json['can'] != null ? Can.fromJson(json['can']) : null;
    canViewError = json['can_view_error'];
    id = json['id'];
    status = json['status'];
    label = json['label'];
    title = json['title'];
    type = json['type'];
    link = json['link'];
    accessDays = json['access_days'];
    liveWebinarStatus = json['live_webinar_status'];
    authHasBought = json['auth_has_bought'];
    sales = json['sales'] != null ? Sales.fromJson(json['sales']) : null;
    isFavorite = json['is_favorite'];
    priceString = json['price_string'];
    bestTicketString = json['best_ticket_string'];
    price = json['price'];
    tax = json['tax'];
    taxWithDiscount = json['tax_with_discount'];
    bestTicketPrice = json['best_ticket_price'];
    discountPercent = json['discount_percent'];
    coursePageTax = json['course_page_tax'];
    priceWithDiscount = json['price_with_discount'];
    discountAmount = json['discount_amount'];
    
    activeSpecialOffer = json['active_special_offer'] != null ? ActiveSpecialOffer.fromJson(json['active_special_offer']) : null;

    duration = int.tryParse( json['duration']?.toString() ?? '0');
    teacher = json['teacher'] != null ? UserModel.fromJson(json['teacher']) : null;
    studentsCount = json['students_count'];
    rate = json['rate']?.toString();
    rateType = json['rate_type'] != null
        ? RateType.fromJson(json['rate_type'])
        : null;
    createdAt = json['created_at'];
    startDate = json['start_date'];
    purchasedAt = json['purchased_at'];
    reviewsCount = json['reviews_count'];
    points = json['points'];
    progress = json['progress'];
    progressPercent = json['progress_percent'];
    category = json['category'];
    capacity = json['capacity'];
    support = json['support'];
    subscribe = json['subscribe'];
    description = json['description'];

    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }

    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }

    sessionsCount = json['sessions_count'];
    if (json['session_chapters'] != null) {
      sessionChapters = <SessionChapters>[];
      json['session_chapters'].forEach((v) {
        sessionChapters.add(SessionChapters.fromJson(v));
      });
    }

    if (json['files_chapters'] != null) {
      filesChapters = <FilesChapters>[];
      json['files_chapters'].forEach((v) {
        filesChapters.add(FilesChapters.fromJson(v));
      });
    }

    if (json['text_lesson_chapters'] != null) {
      textLessonChapters = <TextLessonChapters>[];
      json['text_lesson_chapters'].forEach((v) {
        textLessonChapters.add(TextLessonChapters.fromJson(v));
      });
    }

    filesCount = json['files_count'];
    textLessonsCount = json['text_lessons_count'];
    quizzesCount = json['quizzes_count'];

    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewModel.fromJson(v));
      });
    }

    
    if (json['tickets'] != null) {
      tickets = <BuyTicketsModel>[];
      json['tickets'].forEach((v) {
        tickets.add(BuyTicketsModel.fromJson(v));
      });
    }
    
    if (json['certificate'] != null) {
      certificates = <CertificateModel>[];
      json['certificate']?.forEach((v) {
        if(v != null){
          certificates.add(CertificateModel.fromJson(v));
        }
      });
    }
    
    if (json['quizzes'] != null) {
      quizzes = <QuizzesModel>[];
      json['quizzes'].forEach((v) {
        quizzes.add(QuizzesModel.fromJson(v));
      });
    }
    
    if (json['prerequisites'] != null) {
      prerequisites = <PrerequisitesModel>[];
      json['prerequisites'].forEach((v) {
        prerequisites.add(PrerequisitesModel.fromJson(v));
      });
    }

    videoDemo = json['video_demo'];
    videoDemoSource = json['video_demo_source'];
    imageCover = json['image_cover'];
    isDownloadable = json['isDownloadable'];
    teacherIsOffline = json['teacher_is_offline'];

    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }

    authHasSubscription = json['auth_has_subscription'];
    canAddToCart = json['can_add_to_cart'];
    canBuyWithPoints = json['can_buy_with_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['cashbackRules'] = cashbackRules.map((v) => v.toJson()).toList();


    data['sales_count_number'] = salesCountNumber;
    data['image'] = image;
    data['auth'] = auth;
    if (can != null) {
      data['can'] = can!.toJson();
    }
    data['can_view_error'] = canViewError;
    data['id'] = id;
    data['status'] = status;
    data['label'] = label;
    data['title'] = title;
    data['type'] = type;
    data['link'] = link;
    data['access_days'] = accessDays;
    data['live_webinar_status'] = liveWebinarStatus;
    data['auth_has_bought'] = authHasBought;
    if (sales != null) {
      data['sales'] = sales!.toJson();
    }
    data['is_favorite'] = isFavorite;
    data['price_string'] = priceString;
    data['best_ticket_string'] = bestTicketString;
    data['price'] = price;
    data['tax'] = tax;
    data['tax_with_discount'] = taxWithDiscount;
    data['best_ticket_price'] = bestTicketPrice;
    data['discount_percent'] = discountPercent;
    data['course_page_tax'] = coursePageTax;
    data['price_with_discount'] = priceWithDiscount;
    data['discount_amount'] = discountAmount;
    data['active_special_offer'] = activeSpecialOffer;
    data['duration'] = duration;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    data['students_count'] = studentsCount;
    data['rate'] = rate;
    if (rateType != null) {
      data['rate_type'] = rateType!.toJson();
    }
    data['created_at'] = createdAt;
    data['start_date'] = startDate;
    data['purchased_at'] = purchasedAt;
    data['reviews_count'] = reviewsCount;
    data['points'] = points;
    data['progress'] = progress;
    data['progress_percent'] = progressPercent;
    data['category'] = category;
    data['capacity'] = capacity;
    data['support'] = support;
    data['subscribe'] = subscribe;
    data['description'] = description;
    if (faqs != null) {
      data['faqs'] = faqs!.map((v) => v.toJson()).toList();
    }
    
    data['comments'] = comments.map((v) => v.toJson()).toList();
    
    data['sessions_count'] = sessionsCount;
    data['files_chapters'] = filesChapters.map((v) => v.toJson()).toList();
    data['quizzes'] = quizzes.map((v) => v.toJson()).toList();
    data['certificate'] = certificates.map((v) => v.toJson()).toList();
    data['tickets'] = tickets.map((v) => v.toJson()).toList();
    data['prerequisites'] = prerequisites.map((v) => v.toJson()).toList();
    data['session_chapters'] = sessionChapters.map((v) => v.toJson()).toList();

    data['files_count'] = filesCount;
    data['text_lessons_count'] = textLessonsCount;
    data['quizzes_count'] = quizzesCount;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['video_demo'] = videoDemo;
    data['video_demo_source'] = videoDemoSource;
    data['image_cover'] = imageCover;
    data['isDownloadable'] = isDownloadable;
    data['teacher_is_offline'] = teacherIsOffline;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['auth_has_subscription'] = authHasSubscription;
    data['can_add_to_cart'] = canAddToCart;
    data['can_buy_with_points'] = canBuyWithPoints;
    return data;
  }
}

class BuyTicketsModel {
  int? id;
  String? title;
  String? subTitle;
  var discount;
  var priceWithTicketDiscount;
  bool? isValid;

  BuyTicketsModel(
      {this.id,
      this.title,
      this.subTitle,
      this.discount,
      this.priceWithTicketDiscount,
      this.isValid});

  BuyTicketsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    discount = json['discount'];
    priceWithTicketDiscount = json['price_with_ticket_discount'];
    isValid = json['is_valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['discount'] = discount;
    data['price_with_ticket_discount'] = priceWithTicketDiscount;
    data['is_valid'] = isValid;
    return data;
  }
}

class ActiveSpecialOffer {
  int? id;
  int? creatorId;
  int? webinarId;
  int? bundleId;
  int? subscribeId;
  int? registrationPackageId;
  String? name;
  int? percent;
  String? status;
  int? createdAt;
  int? fromDate;
  int? toDate;

  ActiveSpecialOffer(
      {this.id,
      this.creatorId,
      this.webinarId,
      this.bundleId,
      this.subscribeId,
      this.registrationPackageId,
      this.name,
      this.percent,
      this.status,
      this.createdAt,
      this.fromDate,
      this.toDate});

  ActiveSpecialOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    webinarId = json['webinar_id'];
    bundleId = json['bundle_id'];
    subscribeId = json['subscribe_id'];
    registrationPackageId = json['registration_package_id'];
    name = json['name'];
    percent = json['percent'];
    status = json['status'];
    createdAt = json['created_at'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creator_id'] = creatorId;
    data['webinar_id'] = webinarId;
    data['bundle_id'] = bundleId;
    data['subscribe_id'] = subscribeId;
    data['registration_package_id'] = registrationPackageId;
    data['name'] = name;
    data['percent'] = percent;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}

class Faqs {
  int? id;
  String? title;
  String? answer;
  int? createdAt;
  int? updatedAt;
  bool isOpen=false;

  Faqs({this.id, this.title, this.answer, this.createdAt, this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['answer'] = answer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class FilesChapters {
  int? id;
  String? title;
  int? topicsCount;
  String? duration;
  String? status;
  var order;
  String? type;
  int? createdAt;
  List? textLessons;
  List? sessions;
  List<Files>? files;
  List? quizzes;
  bool isOpen=false;

  FilesChapters(
      {this.id,
      this.title,
      this.topicsCount,
      this.duration,
      this.status,
      this.order,
      this.type,
      this.createdAt,
      this.textLessons,
      this.sessions,
      this.files,
      this.quizzes});

  FilesChapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    topicsCount = json['topics_count'];
    duration = json['duration'];
    status = json['status'];
    order = json['order'];
    type = json['type'];
    createdAt = json['created_at'];
    
    // if (json['textLessons'] != null) {
    //   textLessons = <Null>[];
    //   json['textLessons'].forEach((v) {
    //     textLessons!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['sessions'] != null) {
    //   sessions = <Null>[];
    //   json['sessions'].forEach((v) {
    //     sessions!.add(Null.fromJson(v));
    //   });
    // }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    // if (json['quizzes'] != null) {
    //   quizzes = <Null>[];
    //   json['quizzes'].forEach((v) {
    //     quizzes!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['topics_count'] = topicsCount;
    data['duration'] = duration;
    data['status'] = status;
    data['order'] = order;
    data['type'] = type;
    data['created_at'] = createdAt;
    if (textLessons != null) {
      data['textLessons'] = textLessons!.map((v) => v.toJson()).toList();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? id;
  String? title;
  var authHasRead;
  String? status;
  var order;
  int? downloadable;
  String? accessibility;
  String? description;
  String? storage;
  String? downloadLink;
  var authHasAccess;
  bool? userHasAccess;
  String? file;
  String? volume;
  String? fileType;
  bool? isVideo;
  var interactiveType;
  var interactiveFileName;
  var interactiveFilePath;
  int? createdAt;
  int? updatedAt;

  Files(
      {this.id,
      this.title,
      this.authHasRead,
      this.status,
      this.order,
      this.downloadable,
      this.accessibility,
      this.description,
      this.storage,
      this.downloadLink,
      this.authHasAccess,
      this.userHasAccess,
      this.file,
      this.volume,
      this.fileType,
      this.isVideo,
      this.interactiveType,
      this.interactiveFileName,
      this.interactiveFilePath,
      this.createdAt,
      this.updatedAt});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authHasRead = json['auth_has_read'];
    status = json['status'];
    order = json['order'];
    downloadable = json['downloadable'];
    accessibility = json['accessibility'];
    description = json['description'];
    storage = json['storage'];
    downloadLink = json['download_link'];
    authHasAccess = json['auth_has_access'];
    userHasAccess = json['user_has_access'];
    file = json['file'];
    volume = json['volume'];
    fileType = json['file_type'];
    isVideo = json['is_video'];
    interactiveType = json['interactive_type'];
    interactiveFileName = json['interactive_file_name'];
    interactiveFilePath = json['interactive_file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['auth_has_read'] = authHasRead;
    data['status'] = status;
    data['order'] = order;
    data['downloadable'] = downloadable;
    data['accessibility'] = accessibility;
    data['description'] = description;
    data['storage'] = storage;
    data['download_link'] = downloadLink;
    data['auth_has_access'] = authHasAccess;
    data['user_has_access'] = userHasAccess;
    data['file'] = file;
    data['volume'] = volume;
    data['file_type'] = fileType;
    data['is_video'] = isVideo;
    data['interactive_type'] = interactiveType;
    data['interactive_file_name'] = interactiveFileName;
    data['interactive_file_path'] = interactiveFilePath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class Tags {
  int? id;
  String? title;

  Tags({this.id, this.title});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class CertificateModel {
  int? id;
  String? title;
  int? time;
  var authStatus;
  int? questionCount;
  int? totalMark;
  int? passMark;
  int? averageGrade;
  int? studentCount;
  int? certificatesCount;
  int? successRate;
  String? status;
  int? attempt;
  int? createdAt;
  int? certificate;
  UserModel? teacher;
  int? authAttemptCount;
  String? attemptState;
  bool? authCanStart;
  CourseModel? webinar;

  CertificateModel(
      {this.id,
      this.title,
      this.time,
      this.authStatus,
      this.questionCount,
      this.totalMark,
      this.passMark,
      this.averageGrade,
      this.studentCount,
      this.certificatesCount,
      this.successRate,
      this.status,
      this.attempt,
      this.createdAt,
      this.certificate,
      this.teacher,
      this.authAttemptCount,
      this.attemptState,
      this.authCanStart,
      this.webinar});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    authStatus = json['auth_status'];
    questionCount = json['question_count'];
    totalMark = json['total_mark'];
    passMark = json['pass_mark'];
    averageGrade = int.tryParse(json['average_grade']?.toString() ?? '0');
    studentCount = json['student_count'];
    certificatesCount = json['certificates_count'];
    successRate = json['success_rate'];
    status = json['status'];
    attempt = json['attempt'];
    createdAt = json['created_at'];
    certificate = json['certificate'];
    teacher = json['teacher'] != null ? UserModel.fromJson(json['teacher']) : null;
    authAttemptCount = json['auth_attempt_count'];
    attemptState = json['attempt_state'];
    authCanStart = json['auth_can_start'];
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['auth_status'] = authStatus;
    data['question_count'] = questionCount;
    data['total_mark'] = totalMark;
    data['pass_mark'] = passMark;
    data['average_grade'] = averageGrade;
    data['student_count'] = studentCount;
    data['certificates_count'] = certificatesCount;
    data['success_rate'] = successRate;
    data['status'] = status;
    data['attempt'] = attempt;
    data['created_at'] = createdAt;
    data['certificate'] = certificate;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    data['auth_attempt_count'] = authAttemptCount;
    data['attempt_state'] = attemptState;
    data['auth_can_start'] = authCanStart;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    return data;
  }
}

class QuizzesModel {
  int? id;
  String? title;
  int? time;
  var authStatus;
  int? questionCount;
  int? totalMark;
  int? passMark;
  String? averageGrade;
  int? studentCount;
  int? certificatesCount;
  int? successRate;
  String? status;
  int? attempt;
  int? createdAt;
  int? certificate;
  UserModel? teacher;
  int? authAttemptCount;
  String? attemptState;
  var authCanStart;
  CourseModel? webinar;

  QuizzesModel(
      {this.id,
      this.title,
      this.time,
      this.authStatus,
      this.questionCount,
      this.totalMark,
      this.passMark,
      this.averageGrade,
      this.studentCount,
      this.certificatesCount,
      this.successRate,
      this.status,
      this.attempt,
      this.createdAt,
      this.certificate,
      this.teacher,
      this.authAttemptCount,
      this.attemptState,
      this.authCanStart,
      this.webinar});

  QuizzesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    authStatus = json['auth_status'];
    questionCount = json['question_count'];
    totalMark = json['total_mark'];
    passMark = json['pass_mark'];
    averageGrade = json['average_grade']?.toString();
    studentCount = json['student_count'];
    certificatesCount = json['certificates_count'];
    successRate = json['success_rate'];
    status = json['status'];
    attempt = json['attempt'];
    createdAt = json['created_at'];
    certificate = json['certificate'];
    teacher =
        json['teacher'] != null ? UserModel.fromJson(json['teacher']) : null;
    authAttemptCount = json['auth_attempt_count'];
    attemptState = json['attempt_state'];
    authCanStart = json['auth_can_start'];
    webinar =
        json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['auth_status'] = authStatus;
    data['question_count'] = questionCount;
    data['total_mark'] = totalMark;
    data['pass_mark'] = passMark;
    data['average_grade'] = averageGrade;
    data['student_count'] = studentCount;
    data['certificates_count'] = certificatesCount;
    data['success_rate'] = successRate;
    data['status'] = status;
    data['attempt'] = attempt;
    data['created_at'] = createdAt;
    data['certificate'] = certificate;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    data['auth_attempt_count'] = authAttemptCount;
    data['attempt_state'] = attemptState;
    data['auth_can_start'] = authCanStart;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    return data;
  }
}

class PrerequisitesModel {
  int? isRequired;
  CourseModel? webinar;

  PrerequisitesModel({this.isRequired, this.webinar});

  PrerequisitesModel.fromJson(Map<String, dynamic> json) {
    isRequired = json['required'];
    webinar = json['webinar'] != null ? CourseModel.fromJson(json['webinar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['required'] = isRequired;
    if (webinar != null) {
      data['webinar'] = webinar!.toJson();
    }
    return data;
  }
}

class SessionChapters {
  int? id;
  String? title;
  int? topicsCount;
  String? duration;
  String? status;
  var order;
  String? type;
  int? createdAt;
  List<TextLessonChapters>? textLessons;
  List<Sessions>? sessions;
  List<Files>? files;
  List<QuizzesModel>? quizzes;
  bool isOpen=false;

  SessionChapters(
      {this.id,
      this.title,
      this.topicsCount,
      this.duration,
      this.status,
      this.order,
      this.type,
      this.createdAt,
      this.textLessons,
      this.sessions,
      this.files,
      this.quizzes});

  SessionChapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    topicsCount = json['topics_count'];
    duration = json['duration']?.toString();
    status = json['status'];
    order = json['order'];
    type = json['type'];
    createdAt = json['created_at'];
    if (json['textLessons'] != null) {
      textLessons = <TextLessonChapters>[];
      json['textLessons'].forEach((v) {
        textLessons!.add(TextLessonChapters.fromJson(v));
      });
    }
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    if (json['quizzes'] != null) {
      quizzes = <QuizzesModel>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(QuizzesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['topics_count'] = topicsCount;
    data['duration'] = duration;
    data['status'] = status;
    data['order'] = order;
    data['type'] = type;
    data['created_at'] = createdAt;
    if (textLessons != null) {
      data['textLessons'] = textLessons!.map((v) => v.toJson()).toList();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? id;
  String? title;
  bool? authHasRead;
  bool? userHasAccess;
  bool? isFinished;
  bool? isStarted;
  String? status;
  var order;
  String? moderatorSecret;
  int? date;
  int? duration;
  String? link;
  String? joinLink;
  bool? canJoin;
  String? sessionApi;
  String? zoomStartLink;
  String? apiSecret;
  String? description;
  int? createdAt;
  int? updatedAt;
  var agoraSettings;

  Sessions(
      {this.id,
      this.title,
      this.authHasRead,
      this.userHasAccess,
      this.isFinished,
      this.isStarted,
      this.status,
      this.order,
      this.moderatorSecret,
      this.date,
      this.duration,
      this.link,
      this.joinLink,
      this.canJoin,
      this.sessionApi,
      this.zoomStartLink,
      this.apiSecret,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.agoraSettings});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authHasRead = json['auth_has_read'];
    userHasAccess = json['user_has_access'];
    isFinished = json['is_finished'];
    isStarted = json['is_started'];
    status = json['status'];
    order = json['order'];
    moderatorSecret = json['moderator_secret'];
    date = json['date'];
    duration = json['duration'];
    link = json['link'];
    joinLink = json['join_link'];
    canJoin = json['can_join'];
    sessionApi = json['session_api'];
    zoomStartLink = json['zoom_start_link'];
    apiSecret = json['api_secret'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agoraSettings = json['agora_settings '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['auth_has_read'] = authHasRead;
    data['user_has_access'] = userHasAccess;
    data['is_finished'] = isFinished;
    data['is_started'] = isStarted;
    data['status'] = status;
    data['order'] = order;
    data['moderator_secret'] = moderatorSecret;
    data['date'] = date;
    data['duration'] = duration;
    data['link'] = link;
    data['join_link'] = joinLink;
    data['can_join'] = canJoin;
    data['session_api'] = sessionApi;
    data['zoom_start_link'] = zoomStartLink;
    data['api_secret'] = apiSecret;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['agora_settings '] = agoraSettings;
    return data;
  }
}

class TextLessonChapters {
  int? id;
  String? title;
  int? topicsCount;
  String? duration;
  String? status;
  var order;
  String? type;
  int? createdAt;
  List<TextLessons>? textLessons;
  List<SessionChapters>? sessions;
  List<Files>? files;
  List<QuizzesModel>? quizzes;
  bool isOpen=false;

  TextLessonChapters(
      {this.id,
      this.title,
      this.topicsCount,
      this.duration,
      this.status,
      this.order,
      this.type,
      this.createdAt,
      this.textLessons,
      this.sessions,
      this.files,
      this.quizzes});

  TextLessonChapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    topicsCount = json['topics_count'];
    duration = json['duration'];
    status = json['status'];
    order = json['order'];
    type = json['type'];
    createdAt = json['created_at'];
    if (json['textLessons'] != null) {
      textLessons = <TextLessons>[];
      json['textLessons'].forEach((v) {
        textLessons!.add(TextLessons.fromJson(v));
      });
    }
    if (json['sessions'] != null) {
      sessions = <SessionChapters>[];
      json['sessions'].forEach((v) {
        sessions!.add(SessionChapters.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    if (json['quizzes'] != null) {
      quizzes = <QuizzesModel>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(QuizzesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['topics_count'] = topicsCount;
    data['duration'] = duration;
    data['status'] = status;
    data['order'] = order;
    data['type'] = type;
    data['created_at'] = createdAt;
    if (textLessons != null) {
      data['textLessons'] = textLessons!.map((v) => v.toJson()).toList();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TextLessons {
  int? id;
  String? title;
  bool? authHasRead;
  bool? authHasAccess;
  bool? userHasAccess;
  int? studyTime;
  var order;
  int? createdAt;
  String? accessibility;
  String? status;
  int? updatedAt;
  String? summary;
  String? content;
  String? locale;
  List<Attachments>? attachments;
  int? attachmentsCount;

  TextLessons(
      {this.id,
      this.title,
      this.authHasRead,
      this.authHasAccess,
      this.userHasAccess,
      this.studyTime,
      this.order,
      this.createdAt,
      this.accessibility,
      this.status,
      this.updatedAt,
      this.summary,
      this.content,
      this.locale,
      this.attachments,
      this.attachmentsCount});

  TextLessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authHasRead = json['auth_has_read'];
    authHasAccess = json['auth_has_access'];
    userHasAccess = json['user_has_access'];
    studyTime = json['study_time'];
    order = json['order'];
    createdAt = json['created_at'];
    accessibility = json['accessibility'];
    status = json['status'];
    updatedAt = json['updated_at'];
    summary = json['summary'];
    content = json['content'];
    locale = json['locale'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    attachmentsCount = json['attachments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['auth_has_read'] = authHasRead;
    data['auth_has_access'] = authHasAccess;
    data['user_has_access'] = userHasAccess;
    data['study_time'] = studyTime;
    data['order'] = order;
    data['created_at'] = createdAt;
    data['accessibility'] = accessibility;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['summary'] = summary;
    data['content'] = content;
    data['locale'] = locale;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['attachments_count'] = attachmentsCount;
    return data;
  }
}

class Attachments {
  int? id;
  String? title;
  bool? authHasRead;
  String? status;
  var order;
  int? downloadable;
  String? accessibility;
  String? description;
  String? storage;
  String? downloadLink;
  bool? authHasAccess;
  bool? userHasAccess;
  String? file;
  String? volume;
  String? fileType;
  bool? isVideo;
  String? interactiveType;
  String? interactiveFileName;
  String? interactiveFilePath;
  int? createdAt;
  int? updatedAt;

  Attachments(
      {this.id,
      this.title,
      this.authHasRead,
      this.status,
      this.order,
      this.downloadable,
      this.accessibility,
      this.description,
      this.storage,
      this.downloadLink,
      this.authHasAccess,
      this.userHasAccess,
      this.file,
      this.volume,
      this.fileType,
      this.isVideo,
      this.interactiveType,
      this.interactiveFileName,
      this.interactiveFilePath,
      this.createdAt,
      this.updatedAt});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authHasRead = json['auth_has_read'];
    status = json['status'];
    order = json['order'];
    downloadable = json['downloadable'];
    accessibility = json['accessibility'];
    description = json['description'];
    storage = json['storage'];
    downloadLink = json['download_link'];
    authHasAccess = json['auth_has_access'];
    userHasAccess = json['user_has_access'];
    file = json['file'];
    volume = json['volume'];
    fileType = json['file_type'];
    isVideo = json['is_video'];
    interactiveType = json['interactive_type'];
    interactiveFileName = json['interactive_file_name'];
    interactiveFilePath = json['interactive_file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['auth_has_read'] = authHasRead;
    data['status'] = status;
    data['order'] = order;
    data['downloadable'] = downloadable;
    data['accessibility'] = accessibility;
    data['description'] = description;
    data['storage'] = storage;
    data['download_link'] = downloadLink;
    data['auth_has_access'] = authHasAccess;
    data['user_has_access'] = userHasAccess;
    data['file'] = file;
    data['volume'] = volume;
    data['file_type'] = fileType;
    data['is_video'] = isVideo;
    data['interactive_type'] = interactiveType;
    data['interactive_file_name'] = interactiveFileName;
    data['interactive_file_path'] = interactiveFilePath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ReviewModel {
  int? id;
  UserModel? user;
  int? createdAt;
  String? description;
  String? rate;
  RateType? rateType;

  ReviewModel(
      {this.id,
      this.user,
      this.createdAt,
      this.description,
      this.rate,
      this.rateType});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    description = json['description'];
    rate = json['rate'];
    rateType = json['rate_type'] != null
        ? RateType.fromJson(json['rate_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    data['description'] = description;
    data['rate'] = rate;
    if (rateType != null) {
      data['rate_type'] = rateType!.toJson();
    }
    return data;
  }
}



class CashbackRules {
  int? id;
  String? targetType;
  int? startDate;
  int? endDate;
  int? amount;
  String? amountType;
  int? applyCashbackPerItem;
  int? maxAmount;
  int? minAmount;
  int? enable;
  int? createdAt;
  String? title;
  List<Translations>? translations;

  CashbackRules(
      {this.id,
      this.targetType,
      this.startDate,
      this.endDate,
      this.amount,
      this.amountType,
      this.applyCashbackPerItem,
      this.maxAmount,
      this.minAmount,
      this.enable,
      this.createdAt,
      this.title,
      this.translations});

  CashbackRules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    targetType = json['target_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    amount = json['amount'];
    amountType = json['amount_type'];
    applyCashbackPerItem = json['apply_cashback_per_item'];
    maxAmount = json['max_amount'];
    minAmount = json['min_amount'];
    enable = json['enable'];
    createdAt = json['created_at'];
    title = json['title'];
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
    data['target_type'] = targetType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['amount'] = amount;
    data['amount_type'] = amountType;
    data['apply_cashback_per_item'] = applyCashbackPerItem;
    data['max_amount'] = maxAmount;
    data['min_amount'] = minAmount;
    data['enable'] = enable;
    data['created_at'] = createdAt;
    data['title'] = title;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  int? cashbackRuleId;
  String? locale;
  String? title;

  Translations({this.id, this.cashbackRuleId, this.locale, this.title});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cashbackRuleId = json['cashback_rule_id'];
    locale = json['locale'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cashback_rule_id'] = cashbackRuleId;
    data['locale'] = locale;
    data['title'] = title;
    return data;
  }
}





