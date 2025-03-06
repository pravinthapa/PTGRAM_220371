import 'package:flutter/material.dart';
import 'package:prabin/common/route/route.dart';
import 'package:prabin/feature/auth/page/login_page.dart';
import 'package:prabin/feature/dashboard/page/dashboard_page.dart';
import 'package:prabin/feature/onboarding/on_boarding_screen.dart';
import 'package:prabin/feature/splash/splash_page.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.root:
        return PageTransition(
          child: const SplashWidget(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      case Routes.loginPage:
        return PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      case Routes.dashboardPage:
        return PageTransition(
          child: const DashboardPage(),
          type: PageTransitionType.fade,
          settings: routeSettings,
        );
      case Routes.onboardingPage:
        return PageTransition(
          child: const OnBoardScreenWidget(),
          type: PageTransitionType.fade,
          settings: routeSettings,
        );
      default:
        return PageTransition(
          child: const SplashWidget(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          alignment: Alignment.center,
        );
    }
  }
}
