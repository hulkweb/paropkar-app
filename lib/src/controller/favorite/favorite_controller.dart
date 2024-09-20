import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/favorite/favorite_list_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_screen.dart';

class FavoriteController extends ChangeNotifier {
  FavoriteController() {
    changeFavoritesDataStatus(DataStatus.loading);
    getFavorites();
  }

  FavoriteModel? favorites;
  DataStatus _cartsDataStatus = DataStatus.loading;
  DataStatus get cartsDataStatus => _cartsDataStatus;
  changeFavoritesDataStatus(DataStatus status) {
    _cartsDataStatus = status;
    print('status changed of getcart $status');
    notifyListeners();
  }

  getFavorites() {
    if (kDebugMode) {
      print('========calling getFavorite=========');
    }
    getApi(
      url: AppUrl.favorites,
      onSuccess: (response) {
        favorites = FavoriteModel.fromJson(response);
        if (kDebugMode) {
          print('fav data changing here');
        }
        changeFavoritesDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeFavoritesDataStatus(DataStatus.error);
      },
      onException: () {
        changeFavoritesDataStatus(DataStatus.error);
      },
    );
  }

  int _cartIndex = -1;
  int get cartIndex => _cartIndex;
  DataStatus _addFavoriteDataStatus = DataStatus.success;
  DataStatus get addFavoriteDataStatus => _addFavoriteDataStatus;

  changeFavoriteIndex(int index) {
    _cartIndex = index;
    notifyListeners();
  }

  changeAddFavoritesDataStatus(DataStatus status) {
    _addFavoriteDataStatus = status;
    print('status changed of add fav $status');
    notifyListeners();
  }

  addFavorite(
      {required String product_id,
      required String variation_id,
      required String quantity,
      required BuildContext context}) {
    changeAddFavoritesDataStatus(DataStatus.loading);
    postApi(
      body: {
        'product_id': product_id,
        'variation_id': variation_id,
        'quantity': quantity
      },
      url: AppUrl.carts,
      onSuccess: (response) {
        getFavorites();
        changeAddFavoritesDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeAddFavoritesDataStatus(DataStatus.error);
      },
      onException: () {
        changeAddFavoritesDataStatus(DataStatus.error);
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
