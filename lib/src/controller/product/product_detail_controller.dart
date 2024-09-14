import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailController extends ChangeNotifier {
  ontapProduct({required String productId, required BuildContext context}) {
    AppNavigation.navigationPush(context,  ProductDetailScreen());
  }

  int _productCount = 0;
  int get productCount => _productCount;

  ontapProductIncrease() {
    _productCount++;
    notifyListeners();
  }

  ontapProductDecrease() {
    _productCount--;
    notifyListeners();
  }
}
