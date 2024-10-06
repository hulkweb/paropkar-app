import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/accept_continue_screen.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/custom_widgets/otp_custom.dart';

class OtpVerifyScreen extends StatefulWidget {
  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();

  final signupController = SignUpController();

  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose(); // Don't forget to dispose the FocusNode
    super.dispose();
  }

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
                  'Enter OTP',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 50,
                ),
                OtpFields(
                  pinController: signupController.otpFieldController,
                  focusNode: _focusNode,
                  onChanged: (pin) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      // First part of the text
                      text: 'Don’t receive OTP ? ',
                      style: Theme.of(context).textTheme.labelMedium!,
                      children: <TextSpan>[
                        // Second part of the text
                        TextSpan(
                          text: 'Resend',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonText: 'Verify Continue',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.verifyOtp(context);
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
