import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_pref_model.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';

class RegistrationController extends ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? nameValidation(value, {String? emptyText}) {
    if (value!.isEmpty) {
      return emptyText ?? 'Enter Your Full Name';
    }
    return null;
  }

  // mobile validation
  String? mobileValidation(value) {
    return validatePhone(value);
  }

  // Email validation logic
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Enter Email Address';
    } else if (!value.contains('@') || !value.contains('.')
        // ||
        // !value.contains('com')
        ) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Password';
    }
    return null;
  }

  DataStatus _registerDataStatus = DataStatus.success;
  DataStatus get registerDataStatus => _registerDataStatus;

  // Method to update counter and notify listeners
  void changeRegisterStatus(status) {
    _registerDataStatus = status;
    notifyListeners(); // Notify listeners about the change
  }

  //yUser
  register(BuildContext context) {
    print({
      'name': nameController.value.text,
      'mobile': phoneController.value.text,
      'email': emailController.value.text,
      'password': passwordController.value.text,
      'country_code': '+91'
    });
    changeRegisterStatus(DataStatus.loading);
    postApi(
      isShowMessageToast: false,
      body: {
        'name': nameController.value.text,
        'mobile': phoneController.value.text,
        'email': emailController.value.text,
        'password': passwordController.value.text,
        'country_code': '+91'
      },
      url: AppUrl.register,
      context: context,
      header: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      onSuccess: (response) {
        changeRegisterStatus(DataStatus.success);
        UserPreference userPreference = UserPreference();
        userPreference.saveUser(UserPrefModel(
          data: Data(token: response['token'].toString(), id: response['id']),
        ));
        getToken();
        showDialogBox(
          context,
          type: 'success',
          title: 'Successful',
          description: response['message'].toString(),
          ontapOk: () {
            disposeTextControllers();
            AppNavigation.navigationPush(context, BottomBarListScreen());
          },
        );
      },
      onFailed: (response) {
        changeRegisterStatus(DataStatus.error);
        showDialogBox(
          context,
          type: 'error',
          title: 'Sorry',
          description: response['message'].toString(),
        );
      },
      onException: () {},
    );
  }

  disposeTextControllers() {
    nameController.clear();
    passwordController.clear();
    emailController.clear();
    phoneController.clear();
  }
}
