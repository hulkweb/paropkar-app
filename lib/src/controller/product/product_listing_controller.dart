import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/product/product_listing_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';

class ProductListingController extends ChangeNotifier{
  ontapProductCart({required BuildContext context}) {
    // Provider.of<BottomBarListController>(context).changeIndex(2);
    AppNavigation.navigationReplacement(context, BottomBarListScreen());
  }
  ProductListModel? productsData;
  DataStatus _productDataStatus = DataStatus.loading;
  DataStatus get productDataStatus => _productDataStatus;
  changeDataStatus(DataStatus status) {
    _productDataStatus = status;
    notifyListeners();
  }

  getProducts() async{
    String userId = await getUserId();
    getApi(
      url: "${AppUrl.product}?user_id=$userId",  
      header: {'Accept': 'application/json'},
      onSuccess: (response) {
        productsData = ProductListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {},
    );
  }
}
