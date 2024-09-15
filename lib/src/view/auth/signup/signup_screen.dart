import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/login_controller.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/otp_verify_screen.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:country_picker/country_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String countryCode = '91';
  final _formKey = GlobalKey<FormState>();
  final signupController = SignUpController();
  @override
  Widget build(BuildContext context) {
    return CommanWidget(
      title: 'Get Started With App',
      subtitle: 'Login or Sign Upto Use App',
      widget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Toggle Buttons
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Enter Phone Number',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormWidget(
                  controller: signupController.mobileFieldController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                        height: 50, width: 60, child: getContryCodeWidget()),
                  ),

                  // prefixWidget: const SizedBox(),
                  hintText: 'Mobile Number',
                  validator: (value) {
                    return signupController.mobileValidation(value);
                  },
                ),
                const SizedBox(
                  height: 80,
                ),

                CustomButton(
                  text: 'Continue',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.sendOtp(context);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      // First part of the text
                      text: 'By clicking I accept the ',
                      style: Theme.of(context).textTheme.labelMedium!,
                      children: <TextSpan>[
                        // Second part of the text
                       
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Open the URL
                              signupController.ontapTermCondition();
                            },
                          text: 'Term & Condition and Privacy Policy',
                         style: Theme.of(context).textTheme.labelLarge!.copyWith(decoration: TextDecoration.underline,fontFamily: AppFonts.medium),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? getContryCodeWidget() {
    return SizedBox(
      width: 80, height: 50,
      // child: Text('+$countryCode')
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        // splashColor: Colors.,
        onTap: () {
          return;
          openCountryCode(context, onSelected: (Country country) {
            setState(() {
              countryCode = country.phoneCode;
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 20,
            width: 30,
            child: Row(
              children: [
                Text(
                  '+$countryCode',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    'assets/images/dropdown-arrow.png',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Row(
      //   children: [
      //     const SizedBox(
      //       width: 20,
      //     ),
      //     Text('+$countryCode'),
      //     Material(
      //       borderRadius: BorderRadius.circular(50),
      //       child: InkWell(
      //         borderRadius: BorderRadius.circular(50),
      //         // splashColor: Colors.,
      //         onTap: () {
      //           openCountryCode(context, onSelected: (Country country) {
      //             setState(() {
      //               countryCode = country.phoneCode;
      //             });
      //           });
      //         },
      //         // child: Padding(
      //         //   padding: const EdgeInsets.all(2.0),
      //         //   child: Image.asset(
      //         //     LocalImages.dropdownIcon,
      //         //     height: 12,
      //         //     width: 12,
      //         //   ),
      //         // ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}




// getText('Welcome To B-Town',style: Style.blackDark32Bold,),
