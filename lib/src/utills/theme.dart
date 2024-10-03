import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textfiled_theme.dart';
import 'package:paropkar/src/utills/app_text_theme.dart';
import 'package:paropkar/src/utills/appbar_theme.dart';

class RAppTheme {
  RAppTheme._();
  static ThemeData lightTheme = ThemeData(
      cardColor: AppColors.white,
      useMaterial3: true,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: RTextTheme.lightTextTheme,
      inputDecorationTheme: RTextFieldInputTheme.lightInputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      )));

  static ThemeData darkTheme = ThemeData(
      cardColor: AppColors.black,
      useMaterial3: true,
      fontFamily: 'Poppins',
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.black,
      textTheme: RTextTheme.darkTextTheme,
      inputDecorationTheme: RTextFieldInputTheme.darkInputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      )));
}
