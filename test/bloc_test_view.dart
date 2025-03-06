
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// class MockRegisterUseCase extends Mock implements RegisterUseCase {}

// class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

// void main() {
//   late RegisterBloc registerBloc;
//   late MockRegisterUseCase mockRegisterUseCase;
//   late MockUploadImageUsecase mockUploadImageUsecase;

//   setUp(() {
//     mockRegisterUseCase = MockRegisterUseCase();
//     mockUploadImageUsecase = MockUploadImageUsecase();
//     registerBloc = RegisterBloc(
//       registerUseCase: mockRegisterUseCase,
//       uploadImageUsecase: mockUploadImageUsecase,
//     );

//     registerFallbackValue(RegisterUserParams(
//       name: '',
//       phone: '',
//       username: '',
//       password: '',
//       image: '',
//       email: '',
//       address: '',
//       dob: '',
//       gender: '',
//     ));

//     registerFallbackValue(UploadImageParams(file: File('')));
//   });

//   tearDown(() {
//     registerBloc.close();
//   });

//   test('Initial state should be RegisterState.initial()', () {
//     expect(registerBloc.state, equals(const RegisterState.initial()));
//   });

//   blocTest<RegisterBloc, RegisterState>(
//     'Should emit [isLoading: true, isSuccess: false] when registration is started',
//     build: () {
//       when(() => mockRegisterUseCase.call(any()))
//           .thenAnswer((_) async => const Right('User registered successfully'));
//       return registerBloc;
//     },
//     act: (bloc) => bloc.add(RegisterStudent(
//       context: MockBuildContext(),
//       name: 'John Doe',
//       phone: '1234567890',
//       email: 'john.doe@example.com',
//       username: 'johndoe',
//       password: 'securepassword',
//       address: 'Test Address',
//       dob: '2000-01-01',
//       gender: 'Male',
//     )),
//     expect: () => [
//       const RegisterState(
//           isLoading: true, isSuccess: false, isImageUploaded: false),
//       const RegisterState(
//           isLoading: false, isSuccess: true, isImageUploaded: false),
//     ],
//     verify: (_) {
//       verify(() => mockRegisterUseCase.call(any())).called(1);
//     },
//   );

//   blocTest<RegisterBloc, RegisterState>(
//     'Should emit [isLoading: true, isImageUploaded: true] when image upload is successful',
//     build: () {
//       when(() => mockUploadImageUsecase.call(any()))
//           .thenAnswer((_) async => const Right('image_path.png'));
//       return registerBloc;
//     },
//     act: (bloc) => bloc.add(UploadImage(file: File('test_image.png'))),
//     expect: () => [
//       const RegisterState(
//           isLoading: true, isSuccess: false, isImageUploaded: false),
//       const RegisterState(
//           isLoading: false,
//           isSuccess: false,
//           isImageUploaded: true,
//           imageName: 'image_path.png'),
//     ],
//     verify: (_) {
//       verify(() => mockUploadImageUsecase.call(any())).called(1);
//     },
//   );

//   blocTest<RegisterBloc, RegisterState>(
//     'Should emit [isLoading: true, isImageUploaded: false] when image upload fails',
//     build: () {
//       when(() => mockUploadImageUsecase.call(any())).thenAnswer(
//           (_) async => Left(ApiFailure(message: 'Image upload failed')));
//       return registerBloc;
//     },
//     act: (bloc) => bloc.add(UploadImage(file: File('test_image.png'))),
//     expect: () => [
//       const RegisterState(
//           isLoading: true, isSuccess: false, isImageUploaded: false),
//       const RegisterState(
//           isLoading: false, isSuccess: false, isImageUploaded: false),
//     ],
//     verify: (_) {
//       verify(() => mockUploadImageUsecase.call(any())).called(1);
//     },
//   );

//   testWidgets(
//       'Should emit [isLoading: true, isSuccess: false] when registration fails',
//       (tester) async {
//     // Arrange: Mock a registration failure
//     when(() => mockRegisterUseCase.call(any())).thenAnswer(
//         (_) async => Left(ServerFailure(message: "Registration Failed")));

//     final registerBloc = RegisterBloc(
//       registerUseCase: mockRegisterUseCase,
//       uploadImageUsecase: mockUploadImageUsecase,
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           // ✅ Ensure ScaffoldMessenger is available
//           body: Builder(
//             builder: (context) {
//               return ElevatedButton(
//                 // A trigger button to execute the test
//                 onPressed: () {
//                   registerBloc.add(RegisterStudent(
//                     context: context, // ✅ Provides a real BuildContext
//                     name: 'John Doe',
//                     phone: '1234567890',
//                     email: 'john.doe@example.com',
//                     username: 'johndoe',
//                     password: 'securepassword',
//                     address: 'Test Address',
//                     dob: '2000-01-01',
//                     gender: 'Male',
//                   ));
//                 },
//                 child: Text('Register'),
//               );
//             },
//           ),
//         ),
//       ),
//     );

//     // Act: Tap the button to trigger registration
//     await tester.tap(find.text('Register'));
//     await tester.pumpAndSettle(); // Wait for UI updates

//     // Assert: State should reflect failure
//     expect(registerBloc.state.isSuccess, false);
//     expect(registerBloc.state.isLoading, false);
//     expect(find.text("Registration Failed"),
//         findsOneWidget); // ✅ Verify snackbar appears

//     registerBloc.close(); // Cleanup
//   });
// }

// class MockBuildContext extends Mock implements BuildContext {}