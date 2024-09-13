import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/models/order_model/order_item_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';

class OrderListController with ChangeNotifier {
  OrderListController() {
    if (kDebugMode) {
      print('CheckoutController created');
    }
    getOrders();
  }

  //Order List screen

  List<OrderItemModel> orderItemList = [];

  getOrders() {
    orderItemList.clear();
    orderItemList.addAll([
      OrderItemModel(
        '#13256420',
        'Masala',
        4,
        'Arriving Soon',
      ),
      OrderItemModel(
        '#13256420',
        'Masala',
        4,
        'Arriving Soon',
      ),
      OrderItemModel(
        '#13256420',
        'Masala',
        4,
        'Arriving Soon',
      ),
      OrderItemModel(
        '#13256420',
        'Masala',
        4,
        'Arriving Soon',
      ),
      OrderItemModel(
        '#13256420',
        'Masala',
        4,
        'Arriving Soon',
      ),
    ]);
  }

  ontapOrder(String orderId, BuildContext context) {
    print(orderId);
    AppNavigation.navigation(context, OrderDetailScreen());
  }
}
