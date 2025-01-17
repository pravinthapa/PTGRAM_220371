
import 'package:dartz/dartz.dart';
import 'package:prabin/core/error/failure.dart';
import 'package:prabin/features/auth/data/data_source/student_datasource.dart';
import 'package:prabin/features/auth/domain/entity/student_entity.dart';
import 'package:prabin/features/auth/domain/repository/student_repository.dart';

class StudentLocalRepository implements IStudentRepository {
  final IStudentDataSource _studentDataSource;

  StudentLocalRepository({required IStudentDataSource studentDataSource})
      : _studentDataSource = studentDataSource;
  @override
  Future<Either<Failure, void>> createStudent(
      StudentEntity studentEntity) async {
    try {
      await _studentDataSource.addStudent(studentEntity);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(int id) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() {
    // TODO: implement getAllStudentes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, StudentEntity?>> login(
      String username, String password) async {
    try {
      final result = await _studentDataSource.login(username, password);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  registerStudent({required String name, required String email, required String password}) {}
}
