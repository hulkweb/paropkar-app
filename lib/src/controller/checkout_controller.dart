import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import '../models/splash_model.dart';

class AddressModel {
  String? type = '';
  String? address;
  AddressModel({required this.type, required this.address});
}

class CheckoutController with ChangeNotifier {
  editAddress() {}

  /// address

  List<AddressModel> addressList = [
    AddressModel(
      type: "Home",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
    AddressModel(
      type: "Office",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    )
  ];

  int _addresIndex = 0;
  dynamic get addresIndex => _addresIndex;

  setAddress(int index) {
    _addresIndex = index;
    notifyListeners();
  }

  getAddressIndex() {
    return _addresIndex;
  }

  ///  payment
  String _paymentType = '';
  dynamic get paymentType => _paymentType;

  setPayment(String paymentType) {
    _paymentType = paymentType;
    notifyListeners();
  }

  getPaymentType() {
    return _paymentType;
  }

  // openPopup
  openPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const OrderSuccessPopup(),
    );
  }
  
}
