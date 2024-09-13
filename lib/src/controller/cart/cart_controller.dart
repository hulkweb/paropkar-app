import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_screen.dart';

class CartController extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];
  CartController() {
    getCarts();
  }
  double? subtotal;
  double? deiiveryCages;
  double? discount;
  double? total;

  getCarts() {
    cartItemList.clear();
    cartItemList.addAll([
      CartItemModel('Maida', 'Flours', 350.00, '1 KG', 1),
      CartItemModel('Soya Oil', 'Oil', 250.00, '1 LIT', 10),
      CartItemModel('Maida', 'Flours', 350.00, '1 KG', 1),
    ]);
    subtotal = 850.0;
    deiiveryCages = 100.0;
    discount = 150.0;
    total = 850.0;
  }

  final couponTextController = TextEditingController();

  ontapApplyCoupon(BuildContext context) {
    if (kDebugMode) {
      print('applied');
    }
  }

  void ontapContinueButton(BuildContext context) {
    AppNavigation.navigation(context, CheckoutScreen());
  }
}
