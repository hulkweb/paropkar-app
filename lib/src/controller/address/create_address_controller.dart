import 'package:flutter/cupertino.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/auth/signup/accept_continue_screen.dart';
import 'package:paropkar/src/view/auth/signup/enter_shopname_screen.dart';
import 'package:paropkar/src/view/auth/signup/enter_shops_pincode.dart';
import 'package:paropkar/src/view/auth/signup/otp_verify_screen.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';

class CreateAddressController extends ChangeNotifier {
  // text fields
  final mobileFieldController = TextEditingController();
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final localAddressController = TextEditingController();
  final landMarkController = TextEditingController();

//validations
  String? mobileValidation(value) {
    return validatePhone(value);
  }

  String? nameValidation(value, {String? emptyText}) {
    if (value!.isEmpty) {
      return emptyText ?? 'Enter Your Full Name';
    }
    return null;
  }

  String? pincodeValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Your Pincode';
    }
    if (value!.length < 6) {
      return 'Enter Valid Pincode';
    }
    return null;
  }

 AddressType _selectedAddressType = AddressType.home; // Default to home

  AddressType get selectedAddressType => _selectedAddressType;

  void setAddressType(AddressType type) {
    _selectedAddressType = type;
    notifyListeners(); // This will notify any listeners (UI) to rebuild
  }

  ontapSaveAddress(BuildContext context) {
    AppNavigation.navigationPush(context, EnterShopNameScreen());
  }
}

enum AddressType {
  home,
  office,
}
