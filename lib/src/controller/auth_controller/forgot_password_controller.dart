import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/auth/change_password/new_password_screen.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';

class ForgotPasswordController extends ChangeNotifier {
  final TextEditingController mobileController = TextEditingController();

  String? validationMobile(String? value) {
    if (value!.isEmpty) {
      return 'Mobile number cannot be empty';
    }
    if (value.length < 10) {
      return 'Enter full mobile number';
    }
    return null;
  }

  DataStatus _sentOtpStatus = DataStatus.loading;
  DataStatus get sendOtpStatus => _sentOtpStatus;

  changeSendOtpStatus(DataStatus status) {
    _sentOtpStatus = status;
    notifyListeners();
  }

  sendOtp(BuildContext context) {
    changeSendOtpStatus(DataStatus.loading);
    Map<String, String> bodyField = {'mobile': mobileController.text};
    postApi(
      isStatic: true,
      isShowMessageToast: false,
      body: bodyField,
      header: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      url: AppUrl.forgot_password_temp,
      context: context,
      onSuccess: (response) {
        changeSendOtpStatus(DataStatus.success);
        showDialogBox(
          context,
          type: 'success',
          title: 'Successful',
          description:
              'successfull sent otp' /* response['message'].toString() */,
          ontapOk: () {
            Navigator.pop(context);
            AppNavigation.navigationPush(
                context,
                NewPasswordScreen(
                    otp: '1234' /* response['data']['otp'].toString(), */));
          },
        );
      },
      onFailed: (response) {
        changeSendOtpStatus(DataStatus.error);
        showDialogBox(
          context,
          type: 'error',
          title: 'Sorry!',
          description: response['message'].toString(),
          ontapOk: () {
            Navigator.pop(context);
          },
        );
      },
      onException: () {},
    );
  }

  DataStatus _changePasswordStatus = DataStatus.loading;
  DataStatus get changePasswordStatus => _changePasswordStatus;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();

  changeChangePasswordStatus(DataStatus status) {
    _changePasswordStatus = status;
    notifyListeners();
  }

  String? otpValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Otp';
    }
    if (value!.length < 4) {
      return 'Enter Full  Otp';
    }
    return null;
  }

  String? passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Password';
    }
    if (value!.length < 8) {
      return 'The password must be at least 8 characters';
    }
    return null;
  }

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  passwordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  changePasswordApi(BuildContext context) {
    changeChangePasswordStatus(DataStatus.loading);
    Map<String, String> bodyField = {
      'mobile': mobileController.text,
      'otp': otpController.text,
      'new_password': newPasswordController.text
    };
    postApi(
      isStatic: true,
      isShowMessageToast: false,
      body: bodyField,
      header: {'Accept': 'application/json'},
      url: AppUrl.forgot_password_temp,
      context: context,
      onSuccess: (response) {
        changeChangePasswordStatus(DataStatus.success);
        showDialogBox(
          context,
          type: 'success',
          title: 'Successful',
          description: 'Succefully Changed the password' /* response['message'].toString() */,
          ontapOk: () {
            Navigator.pop(context);
            AppNavigation.pushAndRemoveUntil(context,const LoginScreen());
          },
        );
      },
      onFailed: (response) {
        changeChangePasswordStatus(DataStatus.error);
        showDialogBox(
          context,
          type: 'error',
          title: 'Sorry!',
          description: response['message'].toString(),
          ontapOk: () {
            Navigator.pop(context);
          },
        );
      },
      onException: () {},
    );
  }
}
