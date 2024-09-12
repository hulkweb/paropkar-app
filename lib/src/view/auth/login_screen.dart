import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginWithOtp = true; // To toggle between OTP and Password login

  @override
  Widget build(BuildContext context) {
    return CommanWidget(
      title: 'Login Customer',
      widget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Toggle Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login With OTP button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoginWithOtp = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isLoginWithOtp ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Text(
                        'Login With OTP',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13,color: isLoginWithOtp ? Colors.white : Colors.green, ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  SizedBox(width: 10), // space between buttons

                  // Login With Password button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoginWithOtp = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: !isLoginWithOtp ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Login With Password',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13,color: !isLoginWithOtp ? Colors.white : Colors.green, ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Mobile Number Field
              isLoginWithOtp
                  ? TextFormWidget(
                      fillColor: AppColors.white,
                      hintText: "Enter Mob. Number",
                      validator: (String? value) {
                        return null;
                      },
                      suffixWidget: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomButton(
                          text: 'verify',
                          height: 40,
                          width: 70,
                          borderRadius: 39,
                        ),
                      ),
                    )
                  : TextFormWidget(
                      fillColor: AppColors.white,
                      hintText: "Please Enter Mob. Number",
                      validator: (String? value) {},
                    ),
              const SizedBox(height: 10),

              // Conditional Password or OTP Field
              isLoginWithOtp
                  ? TextFormWidget(
                      fillColor: AppColors.white,
                      hintText: "Please Enter Otp",
                      validator: (String? value) {
                        return null;
                      },
                    )
                  : TextFormWidget(
                      fillColor: AppColors.white,
                      hintText: "Please Enter Password",
                      validator: (String? value) {
                        return null;
                      },
                    ),

              SizedBox(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Forgot password functionality
                      },
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              const CustomButton(
                text: 'Login',
              ),
              TextButton(
                onPressed: () {
                  // Navigate to Sign-up
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text(
                  "Sign-Up",
                  style: AppTextStyles.normalPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
