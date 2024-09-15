import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/address/address_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import 'package:paropkar/src/view/order/order_list_screen.dart';

class ManageAddressController with ChangeNotifier {
  ManageAddressController() {
    if (kDebugMode) {
      print('CheckoutController created');
    }
  }

  /// address

  List<AddressModel> addressList = [
    AddressModel(
      type: "rahul katre",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
    AddressModel(
      type: "Subham jaiswal",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
    AddressModel(
      type: "Deepak Chouhan",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
    AddressModel(
      type: "Rohit sharma",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
    AddressModel(
      type: "Dharmendra pawar",
      address: "345/A Vijay Nagar Ring Road, A.B Road, M.P. Indore",
    ),
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

  ontapSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const OrderSuccessPopup(),
    );
  }

  ontapGoBack(BuildContext context) {
    Navigator.pop(context);
  }
}
