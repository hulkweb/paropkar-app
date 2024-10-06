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
    String  isPopular = '0',
  }) async {
    String userId = await getUserId();
    String url =
        "${AppUrl.product}?category_id=$category_id&subcategory_id=$subcategory_id&search=$search&max_price=$max_price&min_price=$min_price?popular=$isPopular?user_id=$userId";
    if (loading) changeDataStatus(DataStatus.loading);
    print(url);
    getApi(
      url: url,
      onSuccess: (response) {
        productsData = ProductListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {
          productsData = ProductListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
    );
  }
}



class VariationModel {
  final String imageUrl;
  final String name;
  final String color;
  final int quantityFrom;
  final int quantityTo;
  final String variationId;

  VariationModel({
    required this.imageUrl,
    required this.name,
    required this.color,
    required this.quantityFrom,
    required this.quantityTo,
    required this.variationId,
  });
}
