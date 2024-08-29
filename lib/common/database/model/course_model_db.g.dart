// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseModelDBAdapter extends TypeAdapter<CourseModelDB> {
  @override
  final int typeId = 1;

  @override
  CourseModelDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseModelDB()
      ..courseDataJson = fields[0] as String?
      ..contentDataJson = fields[1] as String?
      ..singleContentDataJson = (fields[2] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, CourseModelDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.courseDataJson)
      ..writeByte(1)
      ..write(obj.contentDataJson)
      ..writeByte(2)
      ..write(obj.singleContentDataJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseModelDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
