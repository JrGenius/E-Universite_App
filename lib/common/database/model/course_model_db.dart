

import 'package:hive/hive.dart';

part 'course_model_db.g.dart';

@HiveType(typeId: 1)
class CourseModelDB {

  @HiveField(0)
  String? courseDataJson;

  @HiveField(1)
  String? contentDataJson;

  @HiveField(2)
  List<String>? singleContentDataJson;
}