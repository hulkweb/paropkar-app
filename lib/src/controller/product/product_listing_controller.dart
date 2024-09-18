import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/product/product_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:http/http.dart' as http;

class ProductListingController extends ChangeNotifier {
  ProductListingController() {
    if (kDebugMode) {
      print('hello');
    }
  }

  ontapProduct({required String productId, required BuildContext context}) {
    AppNavigation.navigationPush(context, ProductDetailScreen());
  }

  ontapProductCart({required BuildContext context}) {
    // Provider.of<BottomBarListController>(context).changeIndex(2);
    AppNavigation.navigationReplacement(context, BottomBarListScreen());
  }

  List<ProductModel> productList = [];
  getProducts() {
    getApi(
      url: AppUrl.product,
      onSuccess: (response) {
        List<dynamic> data = jsonDecode(response.body);
        // Convert JSON data to a list of ProductModel objects
        for (int i = 0; i < 3; i++){
            // productList.addAll(List.generate(5, (index) => ));
          // productList =
          //     data.map((json) => ProductModel.fromJson(json)).toList();
        }
      },
    );
  }
}
