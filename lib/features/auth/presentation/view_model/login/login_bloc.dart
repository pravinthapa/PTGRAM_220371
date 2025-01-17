import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required loginStudentUsecase}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        // Simulate login process
        await Future.delayed(const Duration(seconds: 2));

        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          // For now, assume all credentials are valid if not empty
          emit(LoginSuccess(event.email));
        } else {
          emit(LoginFailure('Email or password cannot be empty!'));
        }
      } catch (e) {
        emit(LoginFailure('An error occurred: ${e.toString()}'));
      }
    });

    on<GoogleSignInRequested>((event, emit) {
      // Handle Google Sign-In logic
      emit(LoginFailure('Google Sign-In not implemented'));
    });
  }
}
