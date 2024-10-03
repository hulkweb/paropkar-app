import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_fonts.dart';

class RTextTheme {
  RTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: AppFonts.bold),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.black,fontFamily: AppFonts.semiBold),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black,fontFamily: AppFonts.medium),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black,fontFamily: AppFonts.semiBold),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black,fontFamily: AppFonts.semiBold),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.black,fontFamily: AppFonts.medium),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black,fontFamily: AppFonts.semiBold),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black,fontFamily: AppFonts.medium),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5),fontFamily: AppFonts.semiBold),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black,fontFamily: AppFonts.medium),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.5),fontFamily: AppFonts.medium),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: AppFonts.bold),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: AppFonts.semiBold),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.white,fontFamily: AppFonts.semiBold),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: AppFonts.semiBold),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: AppFonts.semiBold),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white,fontFamily: AppFonts.medium),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: AppFonts.semiBold),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white,fontFamily: AppFonts.medium),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5),fontFamily: AppFonts.semiBold),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white,fontFamily: AppFonts.medium),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5),fontFamily: AppFonts.medium),
  );
}
