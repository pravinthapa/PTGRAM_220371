import 'package:prabin/core/network/hive_service.dart';
import '../model/student_hive_model.dart';

class StudentLocalDataSource {
  final HiveService hiveService;

  StudentLocalDataSource(this.hiveService, {required HiveService HiveService});

  Future<void> addStudent(StudentHiveModel student) async {
    await hiveService.addStudent(student);
  }

  Future<StudentHiveModel?> login(String username, String password) async {
    return await hiveService.login(username, password);
  }
}
