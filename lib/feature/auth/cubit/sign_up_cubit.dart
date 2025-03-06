import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/core/response.dart';
import 'package:ptgram/feature/auth/resources/auth_repo.dart';

class SignUpCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  SignUpCubit({required this.authRepository}) : super(CommonInitial());

  signUp({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(CommonLoading());
    final res = await authRepository.signUp(
      password: password,
      email: email,
      username: username,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
