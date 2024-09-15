import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';

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

  showOtpField(value) {

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
    _isPasswordVisible = value;
    notifyListeners();
  }

  String? passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Password';
    }
    return null;
  }

  verifyMobile(BuildContext context) {
    showOtpField(true);
    return;
    postApi(
      body: {'mobile': mobileFieldController.value},
      url: '',
      context: context,
      onSuccess: (response) {
        showOtpField(context);
        showDialogBox(context,
            type: 'success',
            title: 'Sent Otp',
            description: 'Otp has sent on your device');
      },
      onFailed: (response) {
        showDialogBox(
          context,
          type: 'error',
        );
      },
      onException: () {},
    );
  }

  loginWithOtp(BuildContext context) {
    AppNavigation.navigationPush(context,
        AppNavigation.navigationPush(context, const BottomBarListScreen()));
    return;
    postApi(
      body: {
        'mobile': mobileFieldController.value,
        'otp': otpFieldController.value,
      },
      url: '',
      context: context,
      onSuccess: (response) {
        showCustomToast(title: '');
        AppNavigation.navigationPush(context,
            AppNavigation.navigationPush(context, const BottomBarListScreen()));
      },
      onFailed: (response) {
        showDialogBox(context, type: 'error', title: 'Sorry', description: '');
      },
      onException: () {},
    );
  }

  loginWithPassword(BuildContext context) {
    AppNavigation.navigationPush(context,
        AppNavigation.navigationPush(context, const BottomBarListScreen()));
    return;
    postApi(
      body: {
        'mobile': mobileFieldController.value,
        'password': passwordFieldController.value,
      },
      url: '',
      context: context,
      onSuccess: (response) {
        showCustomToast(title: '');
        AppNavigation.navigationPush(context,
            AppNavigation.navigationPush(context, const BottomBarListScreen()));
      },
      onFailed: (response) {
        showDialogBox(context, type: 'error', title: 'Sorry', description: '');
      },
      onException: () {},
    );
  }
}
