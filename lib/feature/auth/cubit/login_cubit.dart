import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/common/core/data_state.dart';
import 'package:prabin/common/core/response.dart';
import 'package:prabin/feature/auth/resources/auth_repo.dart';


class LoginCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(CommonInitial());

  login({
    required String email,
    required String password,
  }) async {
    emit(CommonLoading());
    final res = await authRepository.login(
      email: email,
      password: password,
      // isRememberMe: isRememberMe
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
