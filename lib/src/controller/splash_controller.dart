import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import '../models/splash_model.dart';

class SplashController {
  final SplashModel model;

  SplashController(this.model);

  void navigateAfterSplash(BuildContext context) {
    Timer(
      const Duration(seconds: 3), // Duration of the splash screen
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()), // Navigate to home screen
      ),
    );
  }
}
