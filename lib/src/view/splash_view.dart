import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/splash_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_dimensions.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';

class SplashView extends StatelessWidget {
  final SplashController controller;

  const SplashView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.navigateAfterSplash(context); // Handle navigation

    return Scaffold(
      // Background color of the splash screen
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.splash_back), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppDimensions.getHeight(5),
                    right: AppDimensions.getHeight(5),
                    bottom: AppDimensions.getHeight(1.5)),
                child: Image.asset(controller.model.logoPath),
              ), // Logo or image from the model
              Text(
                controller.model.subtitile,
                style: AppTextStyles.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
