import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_textfiled_theme.dart';
import 'package:paropkar/src/utills/app_text_theme.dart';
import 'package:paropkar/src/utills/appbar_theme.dart';

class RAppTheme {
  RAppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: RTextTheme.lightTextTheme,
      inputDecorationTheme: RTextFieldInputTheme.lightInputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      )));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: RTextTheme.darkTextTheme,
      inputDecorationTheme: RTextFieldInputTheme.darkInputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      )));
}
