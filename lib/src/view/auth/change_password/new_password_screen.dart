// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/forgot_password_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key, required this.otp});
  final String otp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordController>(
        builder: (context, forgotPasswordController, child) {
      return CommanWidget(
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    largeHeight,
                    CustomTextFormWidget(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      fillColor: AppColors.white,
                      controller: forgotPasswordController.otpController,
                      hintText: "Enter OTP",
                      validator: (value) {
                        return forgotPasswordController.otpValidation(value!);
                      },
                    ),
                    largeHeight,
                    CustomTextFormWidget(
                      isObs: forgotPasswordController.isPasswordVisible,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      fillColor: AppColors.white,
                      controller:
                          forgotPasswordController.newPasswordController,
                      hintText: "Enter New Password",
                      validator: (value) {
                        return forgotPasswordController
                            .passwordValidation(value!);
                      },
                      suffixWidget: InkWell(
                        onTap: () {
                          forgotPasswordController.passwordVisibility(
                              !forgotPasswordController.isPasswordVisible);
                        },
                        child: Icon(forgotPasswordController.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off),
                      ),
                    ),
                    largeHeight,
                    CustomTextFormWidget(
                      isObs: forgotPasswordController.isPasswordVisible,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      fillColor: AppColors.white,
                      controller:
                          forgotPasswordController.confirmPasswordController,
                      hintText: "Confirm Password",
                      validator: (value) {
                        return forgotPasswordController
                            .passwordValidation(value!);
                      },
                      suffixWidget: InkWell(
                        onTap: () {
                          forgotPasswordController.passwordVisibility(
                              !forgotPasswordController.isPasswordVisible);
                        },
                        child: Icon(forgotPasswordController.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .1,
                    ),
                    CustomButton(
                      isLoading: forgotPasswordController.changePasswordStatus == DataStatus.loading,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          if (forgotPasswordController
                                  .newPasswordController.text !=
                              forgotPasswordController
                                  .confirmPasswordController.text) {
                            showToast(
                                message:
                                    'New password and confirm password not equal');
                            return;
                          } else if (forgotPasswordController
                                  .otpController.text !=
                              otp) {
                            showToast(message: 'You have enterd wrong OTP');
                            return;
                          } else {
                            forgotPasswordController.changePasswordApi(context);
                          }
                        }
                      },
                      text: 'Change Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
