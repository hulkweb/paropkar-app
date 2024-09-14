import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/utills/globle_func.dart';

class ProfileEditController {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

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
}
