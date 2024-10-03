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
  }

  FavoriteModel? favorites;
  DataStatus _favoritesDataStatus = DataStatus.loading;
  DataStatus get favoritesDataStatus => _favoritesDataStatus;
  changeFavoritesDataStatus(DataStatus status) {
    _favoritesDataStatus = status;
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
        favorites = FavoriteModel.fromJson(response);
        changeFavoritesDataStatus(DataStatus.error);
      },
      onException: () {
        changeFavoritesDataStatus(DataStatus.error);
      },
    );
  }

 
  DataStatus _addFavoriteDataStatus = DataStatus.success;
  DataStatus get addFavoriteDataStatus => _addFavoriteDataStatus;


  changeAddFavoritesDataStatus(DataStatus status) {
    _addFavoriteDataStatus = status;
    print('status changed of add fav $status');
    notifyListeners();
  }

  addRemoveFavorite({required String product_id, required BuildContext context}) {
    changeAddFavoritesDataStatus(DataStatus.loading);
    postApi(
      body: {'product_id': product_id},
      url: "${AppUrl.addFav}$product_id",
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
  double? subtotal;
  double? deiiveryCages;
  double? discount;
  double? total;
}
