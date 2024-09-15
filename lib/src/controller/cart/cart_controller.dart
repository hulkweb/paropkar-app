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
      CartItemModel(
        productName: 'Maida',
        category: 'Flours',
        price: 350.00,
        quantity: "1",
        id: '1',
      ),
      CartItemModel(
        productName: 'Soya Oil',
        category: 'Maida',
        price: 350.00,
        quantity: "2",
        id: '1',
      ),
      CartItemModel(
        productName: 'Maida',
        category: 'Flours',
        price: 350.00,
        quantity: "1",
        id: '1',
      ),
    ]);
    subtotal = 850.0;
    deiiveryCages = 100.0;
    discount = 150.0;
    total = 850.0;
  }

  onIncreaseProduct({required int index}) {
    cartItemList[index].quantity =
        (int.parse(cartItemList[index].quantity) + 1).toString();
  }

  onDecreaseProduct({required int index}) {
    cartItemList[index].quantity =
        (int.parse(cartItemList[index].quantity) - 1).toString();
  }

  changeProductQuantity({required int index, required String value}) {
    cartItemList[index].quantity = value;
  }

  final couponTextController = TextEditingController();

  ontapApplyCoupon(BuildContext context) {
    if (kDebugMode) {
      print('applied');
    }
  }

  void ontapContinueButton(BuildContext context) {
    AppNavigation.navigationPush(context, CheckoutScreen());
  }
}
