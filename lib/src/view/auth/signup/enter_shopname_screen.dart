import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/enter_shops_pincode.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/custom_widgets/otp_custom.dart';

class EnterShopNameScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final signupController = SignUpController();
  @override
  Widget build(BuildContext context) {
    return CommanWidget(
      widget: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Toggle Buttons

                const SizedBox(
                  height: 50,
                ),

                Text(
                  'Enter Shop’s name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * .1, right: screenWidth * .1),
                  child: Text(
                    'You shop or business name will be used to create invoice',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormWidget(
                  controller: signupController.shopController,
                  contentpadding:
                      EdgeInsets.only(left: 20, bottom: 18, top: 18),
                  fillColor: AppColors.white,
                  hintText: "Shop Name",
                  validator: (String? value) {
                    return signupController.shopValidation(value);
                  },
                ),
                SizedBox(
                  height: screenHeight * .2,
                ),
                CustomButton(
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.ontapShopContinueButton(context);
                    }
                  },
                  buttonText: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
