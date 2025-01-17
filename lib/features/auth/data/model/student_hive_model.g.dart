// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentHiveModelAdapter extends TypeAdapter<StudentHiveModel> {
  @override
  final int typeId = 1;

  @override
  StudentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentHiveModel(
      id: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
      email: fields[3] as String,
      program: fields[4] as String,
      year: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.program)
      ..writeByte(5)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
