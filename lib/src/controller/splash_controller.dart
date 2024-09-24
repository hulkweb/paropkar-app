import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/auth/login_screen%20new.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import '../models/splash_model.dart';

class SplashController {
  final SplashModel model;

  SplashController(this.model);

  void navigateAfterSplash(BuildContext context) async {
    String? token = await getToken();
    print('==============');
    print(token);
    Timer(
      const Duration(seconds: 3), // Duration of the splash screen
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
               token==null || token.isEmpty?     LoginScreen() : const BottomBarListScreen()), // Navigate to home screen
        );
      },
    );
  }
}
