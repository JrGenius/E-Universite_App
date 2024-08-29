class SingleContentModel {
  int? id;
  String? title;
  String? canViewError;
  bool? authHasRead;
  bool? authHasAccess;
  bool? userHasAccess;
  String? fileType;
  String? volume;
  String? storage;
  String? downloadLink;
  String? file;
  int? studyTime;
  int? createdAt;
  String? description;
  String? summary;
  String? content;
  String? locale;
  List<Attachments>? attachments;
  int? attachmentsCount;

  int checkPreviousParts = 0;
  int? date;
  int? duration;
  bool? isFinished;
  bool? isStarted;
  bool? canJoin;
  String? link;
  String? sessionApi;
  String? zoomStartLink;

  String? assignmentStatus;
  bool? passed;

  SingleContentModel(
      {this.id,
      this.title,
      this.canViewError,
      this.authHasRead,
      this.authHasAccess,
      this.userHasAccess,
      this.fileType,
      this.volume,
      this.storage,
      this.downloadLink,
      this.file,
      this.studyTime,
      this.createdAt,
      this.description,
      this.summary,
      this.content,
      this.locale,
      this.attachments,
      this.attachmentsCount});

  SingleContentModel.fromJson(Map<String, dynamic> json) {
    checkPreviousParts = json['check_previous_parts'];
    assignmentStatus = json['assignmentStatus'];
    passed = json['passed'];
    
    id = json['id'];
    title = json['title'];
    canViewError = json['can_view_error'];
    authHasRead = json['auth_has_read'];
    authHasAccess = json['auth_has_access'];
    userHasAccess = json['user_has_access'];
    fileType = json['file_type'];
    volume = json['volume'];
    storage = json['storage'];
    downloadLink = json['download_link'];
    file = json['file'];
    studyTime = json['study_time'];
    createdAt = json['created_at'];
    description = json['description'];
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

    date = json['date'];
    duration = json['duration'];
    isFinished = json['is_finished'];
    isStarted = json['is_started'];
    canJoin = json['can_join'];
    link = json['link'];
    sessionApi = json['session_api'];
    zoomStartLink = json['zoom_start_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['can_view_error'] = canViewError;
    data['auth_has_read'] = authHasRead;
    data['auth_has_access'] = authHasAccess;
    data['user_has_access'] = userHasAccess;
    data['file_type'] = fileType;
    data['volume'] = volume;
    data['storage'] = storage;
    data['download_link'] = downloadLink;
    data['file'] = file;
    data['study_time'] = studyTime;
    data['created_at'] = createdAt;
    data['description'] = description;
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
  int? order;
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
  var interactiveType;
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