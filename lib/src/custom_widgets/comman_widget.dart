import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/splash_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_dimensions.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/utills/constant.dart';

class CommanWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;

  final Widget widget;

  CommanWidget({this.title, this.subtitle, required this.widget});

  @override
  Widget build(BuildContext context) {
    // Handle navigation

    return Scaffold(
      // Background color of the splash screen
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,width: screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.splash_back), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: AppDimensions.getHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppDimensions.getHeight(5),
                    right: AppDimensions.getHeight(5),
                    bottom: AppDimensions.getHeight(1.5)),
                child: Image.asset(AppAssets.logo),
              ), // Logo or image from the model
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title ?? '',
                  style: AppTextStyles.titleWhite,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  subtitle ?? '',
                  style: AppTextStyles.subtitleWhite,
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                width: screenWidth,
                padding: EdgeInsets.zero,
                height: AppDimensions.getHeight(60),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
