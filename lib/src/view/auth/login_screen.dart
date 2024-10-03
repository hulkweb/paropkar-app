// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/login_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/auth/change_password/forgot_pass_mobile_screen.dart';
import 'package:paropkar/src/view/auth/register_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
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
                          'Login With Mobile',
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
                          loginController.otpGetSuccessFunc(false);
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
                            'Login With Email',
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
                              focusnode: loginController.mobileFieldFocusNode,
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
                                  isLoading:
                                      loginController.otpGetSuccess == false &&
                                          loginController.loginDataStatus ==
                                              DataStatus.loading,
                                  ontap: () {
                                    FocusScope.of(context).unfocus();
                                    loginController.otpGetSuccessFunc(false);
                                    loginController.otpFieldController.clear();
                                    loginController.login(context,
                                        type: "mobile");
                                  },
                                  loading: const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CupertinoActivityIndicator(
                                        color: AppColors.white,
                                        radius: 10.0,
                                        animating: true),
                                  ),
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
                                        focusnode:
                                            loginController.otpFieldFocusNode,
                                        scrollPaddingBottom: 100,
                                        controller:
                                            loginController.otpFieldController,
                                        maxLength: 4,
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
                              isLoading:
                                  loginController.otpGetSuccess == true &&
                                      loginController.loginDataStatus ==
                                          DataStatus.loading,
                              ontap: () {
                                if (loginController.otpGetSuccess == true &&
                                    _formKeyOtp.currentState!.validate()) {
                                  loginController.verifyMobile(context);
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
                              controller: loginController.emailFieldController,
                              focusnode: loginController.emailFieldFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              fillColor: AppColors.white,
                              hintText: "Email",
                              validator: (value) {
                                return loginController.emailValidation(value);
                              },
                            ),
                            mediumHeight,
                            CustomTextFormWidget(
                              focusnode: loginController.passwordFieldFocusNode,
                              scrollPaddingBottom: 100,
                              controller:
                                  loginController.passwordFieldController,
                              isObs: loginController.isPasswordVisible,
                              maxLength: 15,
                              keyboardType: TextInputType.visiblePassword,
                              fillColor: AppColors.white,
                              hintText: "Password",
                              validator: (String? value) {
                                return loginController
                                    .passwordValidation(value);
                              },
                              onFieldSubmitted: (p0) {
                                if (_formKeyPass.currentState!.validate()) {
                                  loginController.login(context, type: 'email');
                                }
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
                                      AppNavigation.navigationPush(context, ForgotPasswordScreen());
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
                              isLoading: loginController.loginDataStatus ==
                                  DataStatus.loading,
                              ontap: () {
                                if (_formKeyPass.currentState!.validate()) {
                                  loginController.login(context, type: 'email');
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
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
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
