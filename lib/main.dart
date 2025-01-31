import 'package:flutter/material.dart';
import 'package:prabin/app/app.dart';
import 'package:prabin/app/di/di.dart';
import 'package:prabin/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    App(),
  );
}
