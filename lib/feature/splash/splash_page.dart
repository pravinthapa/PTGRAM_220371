import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/app/theme.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/common/route/route.dart';
import 'package:ptgram/feature/auth/resources/auth_repo.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    RepositoryProvider.of<AuthRepository>(context).initial().whenComplete(() {
      final isLoggedIn =
          RepositoryProvider.of<AuthRepository>(context).isLoggedIn;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        NavigationService.pushNamedReplacement(
            routeName: isLoggedIn.value
                ? Routes.dashboardPage
                : Routes.onboardingPage);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "PTGRAM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            // SizedBox(height: 24.hp),
          ],
        ),
      ),
    );
  }
}
