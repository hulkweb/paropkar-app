import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/profile/profile_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:provider/provider.dart';

class ProfileEditController with ChangeNotifier {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  assignAllData({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
  }) {
    nameController.text = name;
    emailController.text = email;
    phoneNumberController.text = phoneNumber;
    addressController.text = address;
    passwordController.text = password;
  }

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  passwordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  // Validation function

  // Name validation example
  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Enter Last Name';
    }
    return null;
  }

// Last name validation example
  String? validateLaseName(String value) {
    if (value.isEmpty) return 'Enter Last Name';
    return null;
  }

// Last name validation example
  String? validatePassword(String value) {
    if (value.isEmpty) return 'Enter Password';
    if (value.length < 8) return 'Password should be atleast characters';
    return null;
  }

// Address validation example
  String? validateAddress(String value) {
    if (value.isEmpty) return 'Enter Your Address';
    return null;
  }

  // Email validation logic
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'email can not be empty';
    } else if (!value.contains('@') || !value.contains('.')
        // ||
        // !value.contains('com')
        ) {
      return 'please enter  valid email';
    }
    return null;
  }

  // Phone number validation logic
  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Enter Mobile Number';
    }
    if (value.length != 10) {
      return 'Mobile number should be 10 digit';
    }
    return null;
  }

  submitForm(BuildContext context) {
    pop(context);
  }

  DataStatus _userUpdateStaus = DataStatus.error;
  DataStatus get updateStausStatus => _userUpdateStaus;


  changeUpdateUserStatus(DataStatus status) async{
    print('change statas of logout $status');
    _userUpdateStaus = status;
    notifyListeners();
  }

  Future<bool> updateUserApi(
    BuildContext context, {
    required String name,
    required String email,
    required String mobile,
    String? image, // Optional parameter
    required String address,
    required String password,required VoidCallback onSuccess
  }) async {
    if (DataStatus.loading == _userUpdateStaus) {
      return false;
    }
    Map<String, String> file = {};
    if (image != null) {
      file.addAll({'image': image});
    }
    changeUpdateUserStatus(DataStatus.loading);
    await postMultipartApi(
        isShowMessageToast: true,
        body: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'image': image ??
              '', // If the image is null, it defaults to an empty string
          'address': address,
          'password': password,
        },
        onSuccess: (response) {
          changeUpdateUserStatus(DataStatus.success);
          Navigator.pop(context);
           return true;
        },
        onFailed: (p0) {
          changeUpdateUserStatus(DataStatus.error); return false;
        },
        url: AppUrl.update_profile,
        onException: () {
          changeUpdateUserStatus(DataStatus.error); return false;
        },
        context: context,
        files: file);
    return false;
    // return isLogout;
  }
}
