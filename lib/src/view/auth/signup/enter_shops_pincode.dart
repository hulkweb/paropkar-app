import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/custom_widgets/otp_custom.dart';

class EnterShopsPincodeScreen extends StatelessWidget {
  EnterShopsPincodeScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final signupController = SignUpController();
  @override
  Widget build(BuildContext context) {
    return CommanWidget(
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

                Text(
                  'Enter Shop’s Pincode',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                SizedBox(
                  height: screenHeight * .1,
                ),
                smallHeight,
                CustomTextFormWidget(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: signupController.pincodeController,
                  fillColor: AppColors.white,
                  hintText: "Pincode",
                  validator: (String? value) {
                    return signupController.pincodeValidation(value);
                  },
                ),
                SizedBox(
                  height: screenHeight * .1,
                ),
                CustomButton(
                  text: 'Continue',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.ontapPincodeContinueButton(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
