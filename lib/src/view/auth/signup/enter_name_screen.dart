import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/utills/constant.dart';
import 'package:paropkar/src/view/auth/signup/enter_shopname_screen.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class EnterNameScreen extends StatefulWidget {
  EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
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
                  'Enter Your Name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                largeHeight,
                CustomTextFormWidget(
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  fillColor: AppColors.white,
                  controller: signupController.nameController,
                  hintText: "Full Name",
                  validator: (value) {
                   return signupController.nameValidation(value);
                  },
                ),
                SizedBox(
                  height: screenHeight * .2,
                ),
                CustomButton(
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.ontapNameContinueButton(context);
                    }
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
