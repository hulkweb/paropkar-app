import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/models/order_model/product_order_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/customer_detail_screen.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';

class CustomerDetailController with ChangeNotifier {
  CustomerDetailController() {
    if (kDebugMode) {
      print('CustomerDetailController created');
    }
    chnageStatus('readyToPickup');
  }

  String _orderStatus = 'readyToPickup';
  String get orderSatus => _orderStatus;

  chnageStatus(String status) {
    //status keys = readyToPickup,orderProcessed,paymentConfirm,orderPlaced
    _orderStatus = status;
    notifyListeners();
  }
}
