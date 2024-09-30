import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_screen.dart';

class CartController extends ChangeNotifier {
  CartController() {
    changeCartsDataStatus(DataStatus.loading);
    // getCarts();
  }

  CartModel? carts;
  DataStatus _cartsDataStatus = DataStatus.loading;
  DataStatus get cartsDataStatus => _cartsDataStatus;
  changeCartsDataStatus(DataStatus status) {
    _cartsDataStatus = status;
    print('status changed of getcart $status');
    notifyListeners();
  }

  getCarts() {
    print('========calling getCart=========');
    getApi(
      url: AppUrl.carts,
      onSuccess: (response) {
        carts = CartModel.fromJson(response);
        if (kDebugMode) {
          print('cart data changing here');
        }
        changeCartsDataStatus(DataStatus.success);
      },
      onFailed: (response) {
         carts = CartModel.fromJson(response);
        changeCartsDataStatus(DataStatus.success);
      },
      onException: () {
        changeCartsDataStatus(DataStatus.error);
      },
    );
  }

  int _cartIndex = -1;
  int get cartIndex => _cartIndex;
  DataStatus _addCartDataStatus = DataStatus.success;
  DataStatus get addCartDataStatus => _addCartDataStatus;

  changeCartIndex(int index) {
    _cartIndex = index;
    notifyListeners();
  }

  changeAddCartsDataStatus(DataStatus status) {
    _addCartDataStatus = status;
    print('status changed of add cart $status');
    notifyListeners();
  }

  addCart(
      {required String product_id,
      required String quantity,
      required String variation_id,
      required BuildContext context}) async {
    changeAddCartsDataStatus(DataStatus.loading);
    await postApi(
      body: {
        'product_id': product_id,
        'quantity': quantity,
        'variation_id': variation_id
      },
      url: AppUrl.addcart,
      onSuccess: (response) {
        getCarts();
        changeAddCartsDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeAddCartsDataStatus(DataStatus.error);
      },
      onException: () {
        changeAddCartsDataStatus(DataStatus.error);
      },
      context: context,
    );
  }

  removeCart({required String cart_id, required BuildContext context}) {
    changeAddCartsDataStatus(DataStatus.loading);
    postApi(
      body: {'cart_id': cart_id},
      url: AppUrl.removecart,
      onSuccess: (response) {
        getCarts();
        changeAddCartsDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeAddCartsDataStatus(DataStatus.error);
      },
      onException: () {
        changeAddCartsDataStatus(DataStatus.error);
      },
      context: context,
    );
  }

  changeCartQuantity(
      {required String cart_id,
      required String quntity,
      required BuildContext context}) {
    changeAddCartsDataStatus(DataStatus.loading);
    postApi(
      body: {'cart_id': cart_id, 'quantity': quntity},
      url: AppUrl.change_quantity,
      onSuccess: (response) {
        getCarts();
        changeAddCartsDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeAddCartsDataStatus(DataStatus.error);
      },
      onException: () {
        changeAddCartsDataStatus(DataStatus.error);
      },
      context: context,
    );
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

  double? subtotal;
  double? deiiveryCages;
  double? discount;
  double? total;
}
