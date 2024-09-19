import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/product/product_listing_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';

class ProductListingController extends ChangeNotifier{
  ProductListingController(){
    getProducts();
  }

  ontapProduct({required String productId, required BuildContext context}) {
    AppNavigation.navigationPush(context, ProductDetailScreen(id: '',));
  }

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

  getProducts() {
    getApi(
      url: AppUrl.product,
      header: {'Accept': 'application/json'},
      onSuccess: (response) {
        productsData = ProductListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {},
    );
  }
}
