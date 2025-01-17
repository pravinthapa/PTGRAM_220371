import 'package:prabin/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<void> addStudent(StudentEntity student);
  Future<void> deleteStudent(String studentId);
  Future<List<StudentEntity>> getStudents();
  Future<StudentEntity?> login(String username, String password);
}
