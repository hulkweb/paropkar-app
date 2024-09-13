import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueAccent,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87, // Dark color for light theme
      ),
      headline2: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headline3: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      headline4: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
      headline5: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      subtitle1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      subtitle2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      caption: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      button: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      overline: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.normal,
        color: Colors.black38,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        color: Colors.white70, // Light color for dark theme
      ),
      headline2: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      headline3: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w500,
        color: Colors.white60,
      ),
      headline4: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(153, 23, 18, 18),
      ),
      headline5: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      subtitle1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      subtitle2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white60,
      ),
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.white60,
      ),
      caption: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white60,
      ),
      button: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      overline: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.normal,
        color: Colors.white38,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.grey,
    ),
  );

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
