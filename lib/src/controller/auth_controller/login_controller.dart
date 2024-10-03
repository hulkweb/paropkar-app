import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_pref_model.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';

import '../../user_preference/user_pref/user_preference.dart';

class LoginController extends ChangeNotifier {
  String _screenType = 'loginWithOtp';
  String get screenType => _screenType;

  changeScreenType(String screenType){
    mobileFieldController.clear();
    passwordFieldController.clear();
    otpFieldController.clear();
    // print(screenType);
    //loginWithOtp, loginWithPass
    _screenType = screenType;

    notifyListeners();
  }

  final mobileFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final mobileFieldFocusNode = FocusNode();
  final emailFieldFocusNode = FocusNode();
  bool _otpGetSuccess = false;
  bool get otpGetSuccess => _otpGetSuccess;

  otpGetSuccessFunc(value) {
    _otpGetSuccess = value;
    notifyListeners();
  }

  String? mobileValidation(value) {
    return validatePhone(value);
  }

  String? emailValidation(value) {
    return validateEmail(value);
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
  final otpFieldFocusNode = FocusNode();

  String? otpValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Otp';
    }
    if (value!.length < 4) {
      return 'Enter Full  Otp';
    }
    return null;
  }

  final passwordFieldController = TextEditingController();
  final passwordFieldFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  passwordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  String? passwordValidation(value){
    if (value!.isEmpty) {
      return 'Enter Password';
    }
    if (value!.length < 8) {
      return 'The password must be at least 8 characters';
    }
    return null;
  }

  verifyMobile(BuildContext context) {
    changeLoginStatus(DataStatus.loading);
    postApi(
      isShowMessageToast: false,
      body: {
        'mobile': mobileFieldController.value.text,
        'otp': otpFieldController.value.text
      },
      url: AppUrl.verifyotp,
      context: context,
      onSuccess: (response) {
        changeLoginStatus(DataStatus.success);
        UserPreference userPreference = UserPreference();
        userPreference.saveUser(UserPrefModel.fromJson(response));
        getToken();
        showDialogBox(
          context,
          type: 'success',
          title: 'Successful',
          description: response['message'].toString(),
          ontapOk: () {
            AppNavigation.navigationPush(context, const BottomBarListScreen());
          },
        );
      },
      onFailed: (response) {
        changeLoginStatus(DataStatus.error);
        if (response['success'] == false) {
          showDialogBox(context,
              type: 'error',
              title: 'Sorry!',
              description: response['message'] ?? '');
        }
      },
      onException: () {
        changeLoginStatus(DataStatus.error);
      },
    );
  }

  DataStatus _loginDataStatus = DataStatus.success;
  DataStatus get loginDataStatus => _loginDataStatus;

  // Method to update counter and notify listeners
  void changeLoginStatus(status) {
    _loginDataStatus = status;
    notifyListeners(); // Notify listeners about the change
  }

  login(BuildContext context, {required String type}) {
    changeLoginStatus(DataStatus.loading);
    Map<String, String> bodyField = (type == 'mobile')
        ? {
            'mobile': mobileFieldController.value.text,
            'type': 'mobile',
          }
        : {
            'email': emailFieldController.value.text,
            'password': passwordFieldController.value.text,
            'type': 'email',
          };
    postApi(
      isShowMessageToast: false,
      body: bodyField,
      header: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      url: AppUrl.login,
      context: context,
      onSuccess: (response) {
        changeLoginStatus(DataStatus.success);
        if (type == 'mobile') {
          otpGetSuccessFunc(true);
          showDialogBox(
            context,
            type: 'success',
            title: 'Successful',
            description:
                "${response['message'].toString()}\n ${response['data']['otp'].toString()}",
            ontapOk: () {
              Navigator.pop(context);
              otpFieldFocusNode.requestFocus();
            },
          );
        } else {
          UserPreference userPreference = UserPreference();
          userPreference.saveUser(UserPrefModel.fromJson(response));
          getToken();
          showDialogBox(
            context,
            type: 'success',
            title: 'Successful',
            description: response['message'].toString(),
            ontapOk: () {
              disposeTextControllers();
              AppNavigation.navigationPush(
                  context, const BottomBarListScreen());
            },
          );
        }
      },
      onFailed: (response) {
        changeLoginStatus(DataStatus.error);
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

  disposeTextControllers() {
    emailFieldController.clear();
    passwordFieldController.clear();
    mobileFieldController.clear();
    otpFieldController.clear();
  }
}
