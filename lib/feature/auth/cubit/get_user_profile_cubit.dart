import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/core/response.dart';
import 'package:ptgram/feature/auth/model/user_model.dart';
import 'package:ptgram/feature/auth/resources/auth_repo.dart';

class GetUserProfileCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  GetUserProfileCubit({required this.authRepository}) : super(CommonInitial());

  getUserProfile() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await authRepository.getUserProfile();
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<UserModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
