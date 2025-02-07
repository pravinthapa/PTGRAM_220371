import 'package:flutter_test/flutter_test.dart';

import 'dart:io';

// Mock classes
class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockIUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRemoteDataSource mockDataSource;
  late MockSharedPreferences mockSharedPreferences;
  late TokenSharedPrefs tokenSharedPrefs;
  late UserRemoteRepository userRepository;

  setUp(() {
    mockDataSource = MockUserRemoteDataSource();
    mockSharedPreferences = MockSharedPreferences();
    tokenSharedPrefs = TokenSharedPrefs(mockSharedPreferences);
    userRepository = UserRemoteRepository(mockDataSource);
  });

  group('TokenSharedPrefs', () {
    test('should save token successfully', () async {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      final result = await tokenSharedPrefs.saveToken('mock_token');

      expect(result, equals(Right(null)));
    });

    test('should return saved token', () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn('mock_token');

      final result = await tokenSharedPrefs.getToken();

      expect(result, equals(Right('mock_token')));
    });
  });

  group('UserRepository', () {
    test('should create user successfully', () async {
      when(() => mockDataSource.createUser(any()))
          .thenAnswer((_) async => {});

      final result = await userRepository.createUser(
        const UserEntity(
          fullName: "John Doe",
          email: "john@example.com",
          password: "password",
          phone: "1234567890",
          address: "Street 123",
          role: "user",
        ),
      );

      expect(result, equals(Right(null)));
    });

    test('should return token on successful login', () async {
      when(() => mockDataSource.loginUser(any(), any()))
          .thenAnswer((_) async => 'mock_token');

      final result = await userRepository.loginUser('john@example.com', 'password');

      expect(result, equals(Right('mock_token')));
    });

    test('should return a list of users', () async {
      final users = [
        const UserEntity(fullName: "John", email: "john@example.com", password: "pass", phone: "123", address: "xyz", role: "user")
      ];

      when(() => mockDataSource.getAllUsers())
          .thenAnswer((_) async => users);

      final result = await userRepository.getAllUsers();

      expect(result, equals(Right(users)));
    });

    test('should delete a user successfully', () async {
      when(() => mockDataSource.deleteUser(any()))
          .thenAnswer((_) async => {});

      final result = await userRepository.deleteUser("123");

      expect(result, equals(Right(null)));
    });

    test('should upload profile picture successfully', () async {
      when(() => mockDataSource.uploadProfilePicture(any()))
          .thenAnswer((_) async => "profile.jpg");

      final result = await userRepository.uploadProfilePicture(File("path/to/file"));

      expect(result, equals(Right("profile.jpg")));
    });
  });
}