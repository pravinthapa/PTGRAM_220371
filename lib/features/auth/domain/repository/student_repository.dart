import 'package:dartz/dartz.dart';
import 'package:prabin/core/error/failure.dart';
import 'package:prabin/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentRepository {
  Future<Either<Failure, void>> createStudent(StudentEntity studentEntity);
  Future<Either<Failure, List<StudentEntity>>> getAllStudents();
  Future<Either<Failure, void>> deleteStudent(int id);
  Future<Either<Failure, StudentEntity?>> login(
      String username, String password);
}
