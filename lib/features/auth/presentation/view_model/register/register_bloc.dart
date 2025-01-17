import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      // Simulate registration process
      await Future.delayed(const Duration(seconds: 2));

      if (event.email.contains('@') && event.password.length >= 6) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(
            'Invalid email or password must be at least 6 characters.'));
      }
    });
  }
}
