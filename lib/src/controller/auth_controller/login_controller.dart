import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/widgets/textfields/custom_textfied.dart';

class LoginController extends ChangeNotifier {
  String _screenType = 'loginWithOtp';
  String get screenType => _screenType;

  changeScreenType(String screenType) {
    mobileFieldController.clear();
    passwordFieldController.clear();
    otpFieldController.clear();
    // print(screenType);
    //loginWithOtp, loginWithPass
    _screenType = screenType;

    notifyListeners();
  }

  // mobile field
  final mobileFieldController = TextEditingController();
  bool _otpGetSuccess = false;
  bool get otpGetSuccess => _otpGetSuccess;

  otpGetSuccessFunc(value) {
    _otpGetSuccess = value;
    notifyListeners();
  }

  String? mobileValidation(value) {
    return validatePhone(value);
  }

  veryfyMobile(value) {
    print(mobileFieldController.text.length);
    if (mobileFieldController.text.length < 10) {
      showCustomToast(title: 'Enter valid mobile number');
      return;
    }
    otpGetSuccessFunc(value);
  }

  // otp field
  final otpFieldController = TextEditingController();

  String? otpValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Otp';
    }
    if (value!.length < 6) {
      return 'Enter Full  Otp';
    }
    return null;
  }

  final passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  passwordVisibility(bool value) {
    print('rtyuiuygtfghjhgfd');
    print(value);
    _isPasswordVisible = value;
    print(_isPasswordVisible);
    notifyListeners();
  }

  String? passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Password';
    }

    return null;
  }

  //verify otp
  verifyOtp(BuildContext context) {
    AppNavigation.navigationPush(context, BottomBarListScreen());
  }

  verifyPass(BuildContext context) {
    AppNavigation.navigationPush(context, BottomBarListScreen());
  }
}
