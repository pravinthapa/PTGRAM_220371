import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prabin/features/onboarding/presentation/view/onboard.dart';

class SplashscreenCubit extends Cubit<void> {
  SplashscreenCubit() : super(null);

  void navigateToOnboardView(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen1()),
      );
    });
  }
}
