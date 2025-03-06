import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/feature/auth/cubit/login_cubit.dart';
import 'package:ptgram/feature/auth/widget/login_widget.dart';
import 'package:ptgram/feature/dashboard/page/dashboard_page.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';

class MockLoginCubit extends Mock implements LoginCubit {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  late MockLoginCubit mockLoginCubit;
  late MockNavigationService mockNavigationService;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
    mockNavigationService = MockNavigationService();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<LoginCubit>.value(
        value: mockLoginCubit,
        child: const SignInScreen(),
      ),
    );
  }

  group('SignInScreen', () {
    testWidgets('displays email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Check if there are two TextFields (one for email and one for password)
      expect(find.byType(TextField), findsNWidgets(2));
      // Check if the hint text for the email and password fields is correct
      expect(find.text('Enter Your Email'), findsOneWidget);
      expect(find.text('Enter Your Password'), findsOneWidget);
    });

    testWidgets('login button triggers login method',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Find the email and password text fields
      final emailField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;
      // Find the Submit button
      final loginButton = find.text('Submit');

      // Enter some text into the email and password fields
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      // Tap the Submit button
      await tester.tap(loginButton);

      // Verify that the login method was called with the correct parameters
      verify(() => mockLoginCubit.login(
          email: 'test@example.com', password: 'password123')).called(1);
    });

    testWidgets('shows success toast and navigates to DashboardPage on success',
        (WidgetTester tester) async {
      // Simulate a successful login state
      whenListen(
          mockLoginCubit, Stream.fromIterable([CommonStateSuccess(data: null)]),
          initialState: CommonStateSuccess(data: null));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Start the widget and any subsequent actions

      // Verify that a success toast is shown
      verify(() => Fluttertoast.showToast(
            msg: "Sign Up SucessFully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          )).called(1);

      // Verify that the navigation to DashboardPage occurs
      verify(() => NavigationService.push(target: DashboardPage())).called(1);
    });

    testWidgets('shows error toast on failure', (WidgetTester tester) async {
      // Simulate a failure login state
      // whenListen(mockLoginCubit, Stream.fromIterable([CommonError(message: '')]), initialState: CommonStateInitial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Start the widget and any subsequent actions

      // Verify that an error toast is shown
      verify(() => Fluttertoast.showToast(
            msg: 'Login failed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          )).called(1);
    });
  });
}
