import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/common/core/data_state.dart';
import 'package:prabin/common/core/response.dart';
import 'package:prabin/feature/home/repository/real_repository.dart';

class SendLikeCubit extends Cubit<CommonState> {
  final RealsRepository realsRepository;
  SendLikeCubit({required this.realsRepository}) : super(CommonInitial());

  sendLike({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await realsRepository.sendLike(
      id: id,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
