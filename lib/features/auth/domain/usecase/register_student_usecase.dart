
import 'package:prabin/features/auth/data/repository/student_local_repository.dart';

class RegisterStudentUseCase {
  final StudentLocalRepository studentRepository;

  RegisterStudentUseCase({required this.studentRepository});

  Future<bool> registerStudent({
    required String name,
    required String email,
    required String password,
  }) async {
    // Validate inputs if needed
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw ArgumentError("Name, Email, and Password cannot be empty.");
    }

    // Call the repository to register the student
    return await studentRepository.registerStudent(
      name: name,
      email: email,
      password: password,
    );
  }
}
