import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/login_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/utills/constant.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyOtp = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return CommanWidget(
      title: 'Login Customer',
      widget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoginController>(
              builder: (context, loginController, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                largeHeight,
                // Toggle Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login With OTP button
                    GestureDetector(
                      onTap: () {
                        loginController.changeScreenType('loginWithOtp');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: loginController.screenType == 'loginWithOtp'
                              ? Colors.green
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Login With OTP',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize: 13,
                                color:
                                    loginController.screenType == 'loginWithOtp'
                                        ? Colors.white
                                        : Colors.green,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    smallWidth,
                    // Login With Password button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          loginController.changeScreenType('loginWithPass');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color:
                                !(loginController.screenType == 'loginWithOtp')
                                    ? Colors.green
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: Text(
                            'Login With Password',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 13,
                                      color: !(loginController.screenType ==
                                              'loginWithOtp')
                                          ? Colors.white
                                          : Colors.green,
                                    ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                largeHeight,
                loginController.screenType == 'loginWithOtp'
                    ? Form(
                        key: _formKeyOtp,
                        child: Column(
                          children: [
                            CustomTextFormWidget(
                              controller: loginController.mobileFieldController,
                              maxLength: 10,
                              scrollPaddingBottom: 100,
                              keyboardType: TextInputType.phone,
                              fillColor: AppColors.white,
                              hintText: "Mobile Number",
                              validator: (String? value) {
                                return loginController.mobileValidation(value);
                              },
                              suffixWidget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  ontap: () {
                                    loginController.veryfyMobile(true);
                                  },
                                  text: 'verify',
                                  height: 40,
                                  width: 70,
                                  borderRadius: 39,
                                ),
                              ),
                            ),
                            loginController.otpGetSuccess
                                ? Column(
                                    children: [
                                      mediumHeight,
                                      CustomTextFormWidget(
                                        scrollPaddingBottom: 100,
                                        controller: loginController.otpFieldController,
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        fillColor: AppColors.white,
                                        hintText: "Please Enter Otp",
                                        validator: (value) {
                                          return loginController
                                              .otpValidation(value);
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            mediumHeight,
                            CustomButton(
                              ontap: () {
                                if (_formKeyOtp.currentState!.validate()) {
                                  loginController.verifyOtp(context);
                                }
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      )
                    : Form(
                        key: _formKeyPass,
                        child: Column(
                          children: [
                            CustomTextFormWidget(
                              controller: loginController.mobileFieldController,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              fillColor: AppColors.white,
                              hintText: "Mobile Number",
                              validator: (value) {
                                return loginController.mobileValidation(value);
                              },
                            ),
                            mediumHeight,
                            CustomTextFormWidget(
                              scrollPaddingBottom: 100,
                              controller: loginController.passwordFieldController,
                              isObs: loginController.isPasswordVisible,
                              maxLength: 15,
                              keyboardType: TextInputType.visiblePassword,
                              fillColor: AppColors.white,
                              hintText: "Password",
                              validator: (String? value) {
                                return loginController
                                    .passwordValidation(value);
                              },
                              suffixWidget: InkWell(
                                onTap: () {
                                  loginController.passwordVisibility(
                                      !loginController.isPasswordVisible);
                                },
                                child: Icon(loginController.isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off),
                              ),
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomButton(
                              ontap: () {
                                if (_formKeyPass.currentState!.validate()) {
                                  loginController.verifyPass(context);
                                }
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      ),
                // Mobile Number Field
                // isLoginWithOtp
                //     ? CustomTextFormWidget(
                //         fillColor: AppColors.white,
                //         hintText: "Enter Mob. Number",
                //         validator: (String? value) {
                //           return null;
                //         },
                //         suffixWidget: const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: CustomButton(
                //             text: 'verify',
                //             height: 40,
                //             width: 70,
                //             borderRadius: 39,
                //           ),
                //         ),
                //       )
                //     : CustomTextFormWidget(
                //         fillColor: AppColors.white,
                //         hintText: "Please Enter Mob. Number",
                //         validator: (value) {
                //           return loginController.mobileValidation(value);
                //         },
                //       ),
                // const SizedBox(height: 10),

                // // Conditional Password or OTP Field
                // isLoginWithOtp
                //     ? CustomTextFormWidget(
                //         fillColor: AppColors.white,
                //         hintText: "Please Enter Otp",
                //         validator: (value) {
                //           return loginController.otpValidation(value);
                //         },
                //       )
                //     : CustomTextFormWidget(
                //         fillColor: AppColors.white,
                //         hintText: "Please Enter Password",
                //         validator: (String? value) {
                //           return null;
                //         },
                //       ),

                TextButton(
                  onPressed: () {
                    // Navigate to Sign-up
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: AppTextStyles.normalPrimary,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
