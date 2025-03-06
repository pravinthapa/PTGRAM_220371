import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/core/response.dart';
import 'package:ptgram/feature/home/model/reals_model.dart';
import 'package:ptgram/feature/home/repository/real_repository.dart';

class GetRealsCubit extends Cubit<CommonState> {
  final RealsRepository realsRepository;
  GetRealsCubit({required this.realsRepository}) : super(CommonInitial());

  getReals() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await realsRepository.getReals();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<Post>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
