import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xFF77E00D1);
  static const apptheme = Colors.white;
  static const Color secondaryColor = Color(0xFF00B251);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF2f2F2);
  static const Color lighterGrey = Color(0xffF9F9F9);
  static const Color shadowColor = Color(0x1A000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color midGrayColor = Color(0xFFC6C6C6);
  static const Color red = Color(0xffDC143C);
  static const Color pinkColor = Color(0xffFF8C94);
  static const Color blueShadowColor = Color(0xffA8E6CE);
  static const Color greenShadowColor = Color(0xffDCEDC2);
  static const Color lightYello = Color(0xffFFD3B5);
  static const Color lightRedColor = Color(0xffFFAAA6);
  static const Color lightPurpleColor = Color.fromARGB(255, 209, 187, 255);
  static const Color primaryShdowColor = Color.fromARGB(255, 141, 189, 255);
  static const Color blueLight = Color(0xffE9EFF8);
  static const Color skyBlue = Color(0xffE6F8FB);
  static const Color darkRed = Color(0xffC62D38);
  static const Color yellow = Color(0xffFFC727);
  static const Color textGreenColor = Color(0xFF40826D);

  static const Color darkGrey = Color(0xff4D4D4D);

  static const double symmetricHozPadding = 17.0;

  static const MaterialColor primarymaterialcolor =
      MaterialColor(_primarymaterialcolorPrimaryValue, <int, Color>{
    50: Color(0xFFE3E3E7),
    100: Color(0xFFB8B8C4),
    200: Color(0xFF89899C),
    300: Color(0xFF5A5A74),
    400: Color(0xFF363657),
    500: Color(_primarymaterialcolorPrimaryValue),
    600: Color(0xFF111133),
    700: Color(0xFF0E0E2C),
    800: Color(0xFF0B0B24),
    900: Color(0xFF060617),
  });
  static const int _primarymaterialcolorPrimaryValue = 0xFF131339;

  static const MaterialColor primarymaterialcolorAccent =
      MaterialColor(_primarymaterialcolorAccentValue, <int, Color>{
    100: Color(0xFF5858FF),
    200: Color(_primarymaterialcolorAccentValue),
    400: Color(0xFF0000F1),
    700: Color(0xFF0000D7),
  });
  static const int _primarymaterialcolorAccentValue = 0xFF2525FF;
  static ThemeData lightTheme = ThemeData(
      primarySwatch: primarymaterialcolor,
      primaryColor: primaryColor,
      primaryColorDark: primaryColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: primaryColor,
        secondary: primarymaterialcolor.shade700,
        onSecondary: primarymaterialcolor,
        error: red,
        onError: red,
        background: white,
        onBackground: Colors.black,
        surface: white,
        onSurface: white,
        tertiary: secondaryColor,
      ),
      shadowColor: Colors.black,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: primaryColor),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primarymaterialcolorAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      scaffoldBackgroundColor: apptheme,
      iconTheme: const IconThemeData(color: black),
      fontFamily: GoogleFonts.roboto().fontFamily,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      dialogTheme: DialogTheme(
        surfaceTintColor: CustomTheme.white,
        backgroundColor: CustomTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Set your desired radius here
        ),
      ),
      checkboxTheme: CheckboxThemeData(fillColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return lightGray;
      })),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          height: 1.35,
          letterSpacing: 0.5,
        ),
        displayMedium: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        displaySmall: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineSmall: TextStyle(
          color: black,
          fontSize: 16,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleLarge: TextStyle(
          color: black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodySmall: TextStyle(
          color: black,
          fontSize: 8,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleSmall: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleMedium: TextStyle(
          color: black,
          fontSize: 10,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        labelLarge: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyLarge: TextStyle(
          fontSize: 12,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyMedium: TextStyle(
          fontSize: 10,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: white),
      progressIndicatorTheme: ProgressIndicatorThemeData()
          .copyWith(color: primaryColor, circularTrackColor: primaryColor));
}
