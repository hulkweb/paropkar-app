import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/models/order_model/product_order_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/customer_detail_screen.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';

class OrderDetailController with ChangeNotifier {
  OrderDetailController() {
    if (kDebugMode) {
      print('CheckoutController created');
    }
    getproductsList();
  }

  //Order List screen

  List<ProductOrderModel> productOrderList = [];
  double? subtotal;
  double? deiiveryCages;
  double? discount;
  double? total;

  getproductsList() {
    productOrderList.clear();
    productOrderList.addAll([
      ProductOrderModel(
          type: 'Masala', name: 'Hing Powder', quntity: '250g', price: 850),
      ProductOrderModel(
          type: 'Masala', name: 'Hing Powder', quntity: '250g', price: 850),
    ]);
    subtotal = 850.0;
    deiiveryCages = 100.0;
    discount = 150.0;
    total = 850.0;
  }

  ontapCustomerButton(BuildContext context) {
    AppNavigation.navigationPush(context, const CustomerDetailScreen());
  }
}
