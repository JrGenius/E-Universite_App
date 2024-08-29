class NoteModel {
  int? id;
  int? userId;
  int? courseId;
  int? targetableId;
  String? targetableType;
  String? note;
  String? attachment;
  int? createdAt;

  NoteModel(
      {this.id,
      this.userId,
      this.courseId,
      this.targetableId,
      this.targetableType,
      this.note,
      this.attachment,
      this.createdAt});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    targetableId = json['targetable_id'];
    targetableType = json['targetable_type'];
    note = json['note'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['course_id'] = courseId;
    data['targetable_id'] = targetableId;
    data['targetable_type'] = targetableType;
    data['note'] = note;
    data['attachment'] = attachment;
    data['created_at'] = createdAt;
    return data;
  }
}