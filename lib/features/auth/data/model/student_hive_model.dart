import 'package:hive_flutter/hive_flutter.dart';
import 'package:prabin/features/auth/domain/entity/student_entity.dart';

part 'student_hive_model.g.dart'; // Required for Hive's code generation.

@HiveType(typeId: 1)
class StudentHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String program;

  @HiveField(5)
  final String year;

  StudentHiveModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.program,
    required this.year,
  });

  /// Converts `StudentEntity` to `StudentHiveModel`
  factory StudentHiveModel.fromEntity(StudentEntity studentEntity) {
    return StudentHiveModel(
      id: studentEntity.id,
      username: studentEntity.username,
      password: studentEntity.password,
      email: studentEntity.email,
      program: studentEntity.program,
      year: studentEntity.year,
    );
  }

  /// Converts `StudentHiveModel` to `StudentEntity`
  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      username: username,
      password: password,
      email: email,
      program: program,
      year: year,
    );
  }
}
