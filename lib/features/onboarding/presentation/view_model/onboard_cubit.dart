import 'package:bloc/bloc.dart';

class OnboardCubit extends Cubit<int> {
  OnboardCubit() : super(0);

  void updatePage(int pageIndex) {
    emit(pageIndex);
  }
}
