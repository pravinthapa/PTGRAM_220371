import 'package:flutter/material.dart';
import 'package:prabin/core/theme/theme.dart';
import 'package:prabin/features/splash/presentation/view/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashscreenView(),
      },
    );
  }
}
