import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/accept_continue_screen.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class OtpVerifyScreen extends StatefulWidget {
  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  bool isLoginWithOtp = true; // To toggle between OTP and Password login

  @override
  Widget build(BuildContext context) {
    String otpVerificationId = '';
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();
    bool verifyLoading = false;
    bool otpResend = false;
    void loadinTrue() {
      setState(() {
        verifyLoading = true;
      });
    }

    void loadinFalse() {
      setState(() {
        verifyLoading = false;
      });
    }

    return CommanWidget(
      widget: Center(
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
                'Enter OTP',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 50,
              ),

              OtpFields(
                pinController: pinController,
                focusNode: focusNode,
                onChanged: (pin) {
                  setState(() {
                    //change state
                  });
                },
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
                text: 'Verify Continue',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AcceptContinueScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
