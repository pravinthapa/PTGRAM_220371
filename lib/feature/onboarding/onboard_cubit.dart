import 'package:flutter_bloc/flutter_bloc.dart';

enum OnboardingEvent { pageChanged }

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void onPageChanged() {
    emit(state + 1);
  }
}
