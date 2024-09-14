import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/address/address_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import 'package:paropkar/src/view/order/order_list_screen.dart';

class CheckoutController with ChangeNotifier {
  CheckoutController() {
    if (kDebugMode) {
      print('CheckoutController created');
    }
  }

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

  ontapContinue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const OrderSuccessPopup(),
    );
  }

  ontapGoBack(BuildContext context) {
    Navigator.pop(context);
  }

  ontapTrackOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const OrderSuccessPopup(),
    );
  }

  String _orderStatus = 'accept';
  String get orderSatus => _orderStatus;
  chnageStatus(String status) {
    //status keys = accept,pickup,delivered
    _orderStatus = status;
    notifyListeners();
  }

  ontapListTile(BuildContext context) {
    if (kDebugMode) {
      print('navigation');
    }
    AppNavigation.navigationPush(context, OrderListScreen());
  }

  ontapCall() {
    if (kDebugMode) {
      print('call');
    }
    // AppNavigation.navigation(context, OrderListScreen());
  }

  ontapMessage() {
    if (kDebugMode) {
      print('message');
    }
    // AppNavigation.navigation(context, OrderListScreen());
  }
}
