import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prabin/common/navigation/navigation_service.dart';
import 'package:prabin/feature/home/page/ui/home_page.dart';
class ShakeToHomePage extends StatefulWidget {
  @override
  _ShakeToHomePageState createState() => _ShakeToHomePageState();
}

class _ShakeToHomePageState extends State<ShakeToHomePage> {
  late StreamSubscription _accelerometerSubscription;

  // Sensitivity threshold for shake detection
  final double _shakeThreshold = 15.0;
  late DateTime _lastShakeTime;

  @override
  void initState() {
    super.initState();
    _lastShakeTime = DateTime.now();

    // Listen to accelerometer events
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the acceleration magnitude
      double acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      // If the shake magnitude exceeds the threshold, navigate to the home page
      if (acceleration > _shakeThreshold) {
        DateTime now = DateTime.now();
        // Avoid detecting multiple shakes in a short period
        if (now.difference(_lastShakeTime).inMilliseconds > 500) {
          _lastShakeTime = now;
          // Navigate to Home Page
          NavigationService.push(target: HomePage());
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the subscription when the widget is disposed
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shake to Home'),
      ),
      body: Center(
        child: Text('Shake your phone to go to the Home page.'),
      ),
    );
  }
}
