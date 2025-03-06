import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prabin/common/app/app.dart';
import 'package:prabin/common/app/env.dart';
import 'package:prabin/common/hive/auth_hive.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    // await Firebase.initializeApp();

    // // Initialize Awesome Notifications
    // AwesomeNotifications().initialize(
    //   null, // Replace with your app icon or set it to null
    //   [
    //     NotificationChannel(
    //       channelKey: 'basic_channel',
    //       channelName: 'Basic notifications',
    //       channelDescription: 'Notification channel for basic tests',
    //       defaultColor: Color(0xFF9D50DD),
    //       ledColor: Colors.white,
    //     ),
    //   ],
    // );

    // Initialize AuthHive
    await AuthHive.init();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    ).then((_) {
      // DeviceP

      /// device preview
    });

    runApp(
      App(env: EnvValue.development),
    );
  }, (error, stackTrace) {
    // Handle errors
    print('Caught an error: $error');
    print('Stack trace: $stackTrace');
  });
}
