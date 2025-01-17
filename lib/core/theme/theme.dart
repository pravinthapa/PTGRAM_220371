import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto Bold',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red
    )
  );
}
