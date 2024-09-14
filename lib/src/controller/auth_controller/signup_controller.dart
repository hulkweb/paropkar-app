import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/auth/signup/accept_continue_screen.dart';
import 'package:paropkar/src/view/auth/signup/enter_shopname_screen.dart';
import 'package:paropkar/src/view/auth/signup/enter_shops_pincode.dart';
import 'package:paropkar/src/view/auth/signup/otp_verify_screen.dart';
import 'package:paropkar/src/widgets/textfields/custom_textfied.dart';

class SignUpController extends ChangeNotifier {
  // mobile field
  final mobileFieldController = TextEditingController();

  String? mobileValidation(value) {
    return validatePhone(value);
  }
  
  sendOtp(BuildContext context) {
    AppNavigation.navigationPush(context, OtpVerifyScreen());
  }

  void ontapTermCondition() {
    launchURL('www.google.com');
  }

  // otp screen
  final otpFieldController = TextEditingController();
  // final focusNode = FocusNode();

  String? otpValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Otp';
    }
    if (value!.length < 4) {
      return 'Enter Full  Otp';
    }
    return null;
  }

  String? resendOtp(value) {
    showCustomToast(title: 'otp sent on your device');
  }

  verifyOtp(BuildContext context) {
    AppNavigation.navigationPush(context, AcceptContinueScreen());
  }

  /// name screen
  final nameController = TextEditingController();

  ontapNameContinueButton(BuildContext context) {
    AppNavigation.navigationPush(context, EnterShopNameScreen());
  }

  String? nameValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Your Full Name';
    }
    return null;
  }

  /// shop screen
  final shopController = TextEditingController();

  ontapShopContinueButton(BuildContext context) {
    AppNavigation.navigationPush(context, EnterShopsPincodeScreen());
  }

  String? shopValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Your Shop Name';
    }
    return null;
  }

  ///shop's pincode screen
  final pincodeController = TextEditingController();

  ontapPincodeContinueButton(BuildContext context) {
    AppNavigation.navigationPush(context, BottomBarListScreen());
  }

  String? pincodeValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Your Shop Pincode';
    }
    if (value!.length < 6) {
      return 'Enter Valid Pincode';
    }
    return null;
  }
}
