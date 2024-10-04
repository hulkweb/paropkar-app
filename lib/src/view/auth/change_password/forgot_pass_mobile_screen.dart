// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/forgot_password_controller.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = context.read<ForgotPasswordController>();
    return CommanWidget(
      title: 'Change Password',
      widget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Toggle Buttons

                const SizedBox(
                  height: 50,
                ),

                largeHeight,
                CustomTextFormWidget(
                  
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  fillColor: AppColors.white,
                  controller: forgotPasswordController.mobileController,
                  hintText: "Enter Mobile Number",
                  validator: (value) {
                    return forgotPasswordController.validationMobile(value!);
                  },
                ),
                SizedBox(
                  height: screenHeight * .2,
                ),
                Consumer<ForgotPasswordController>(
                  builder: (context,forgotPasswordController,child) {
                    return CustomButton(
                      isLoading: forgotPasswordController.sendOtpStatus == DataStatus.loading,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          forgotPasswordController.sendOtp(context);
                        }
                      },
                      text: 'Send Otp',
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
