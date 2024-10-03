import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/product/product_listing_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';

class ProductListingController extends ChangeNotifier {
  ontapProductCart({required BuildContext context}) {
    // Provider.of<BottomBarListController>(context).changeIndex(2);

    getProducts(loading: true);
    AppNavigation.navigationReplacement(context, BottomBarListScreen());
  }

  ProductListModel? productsData;
  DataStatus _productDataStatus = DataStatus.loading;
  DataStatus get productDataStatus => _productDataStatus;
  changeDataStatus(DataStatus status) {
    _productDataStatus = status;
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  getProducts({
    bool loading = true,
    String category_id = '',
    String subcategory_id = '',
    String search = '',
    String max_price = '',
    String min_price = '',
  }) async {
    String userId = await getUserId();
    if (loading) changeDataStatus(DataStatus.loading);
    print("${AppUrl.product}?user_id=$userId?category_id=$category_id&subcategory_id=$subcategory_id&search=$search&max_price=$max_price&min_price=$min_price");
    getApi(
      url:
          "${AppUrl.product}?user_id=$userId?category_id=$category_id&subcategory_id=$subcategory_id&search=$search&max_price=$max_price&min_price=$min_price",
      onSuccess: (response) {
        productsData = ProductListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {},
    );
  }
}
