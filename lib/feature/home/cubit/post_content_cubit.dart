import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/common/core/data_state.dart';
import 'package:prabin/common/core/response.dart';
import 'package:prabin/feature/home/repository/real_repository.dart';

class PostContentCubit extends Cubit<CommonState> {
  final RealsRepository realsRepository;
  PostContentCubit({required this.realsRepository}) : super(CommonInitial());

  postContent({
    required String description,
    required File? photo,
  }) async {
    emit(CommonLoading());
    final res = await realsRepository.postContent(
      description: description,
      file: photo,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
