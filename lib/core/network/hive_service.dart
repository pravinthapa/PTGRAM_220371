import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/auth/data/model/student_hive_model.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(StudentHiveModelAdapter());
  }

  Future<void> addStudent(StudentHiveModel student) async {
    var box = await Hive.openBox<StudentHiveModel>('students');
    await box.put(student.id, student);
  }

  Future<List<StudentHiveModel>> getAllStudents() async {
    var box = await Hive.openBox<StudentHiveModel>('students');
    return box.values.toList();
  }

  Future<StudentHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<StudentHiveModel>('students');
    return box.values.firstWhere(
      (student) => student.username == username && student.password == password,
    );
  }

  deleteStudent(String studentId) {}
}
