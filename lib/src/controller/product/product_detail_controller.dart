import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/product/product_detail_model.dart';
import 'package:paropkar/src/services/get_api.dart';
// For jsonDecode
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';

class ProductDetailController extends ChangeNotifier {
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

  String _selectedVariationId = '';
  String get selectedVariationId => _selectedVariationId;

  changeVariationId(String variationId) {
    _selectedVariationId = variationId;
    notifyListeners();
  }

  int _quantity = 0;
  int get quantity => _quantity;

  changeQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  
  decrimentQuantity() {
    _quantity--;
    notifyListeners();
  }

  
  incrimentQuantity() {
    _quantity++;
    notifyListeners();
  }

  ProductDetailModel? productDetailData;
  DataStatus _productDetailDataStatus = DataStatus.loading;
  DataStatus get productDetailDataStatus => _productDetailDataStatus;
  changeDataStatus(DataStatus status) {
    _productDetailDataStatus = status;
    print('status changed $status');
    notifyListeners();
  }

  getProductDetail(BuildContext context,
      {required String id, bool loading = true}) {
    // if(loading){
    //   changeDataStatus(DataStatus.loading);
    // }
    print('product detail call');
    for (int i = 0; i < 10; i++) {
      print('\n');
      print('hello');
    }
    getApi(
      url: '${AppUrl.get_single_product}?product_id=$id',
      onSuccess: (response) {
        productDetailData = ProductDetailModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeDataStatus(DataStatus.error);
      },
      context: context,
    );
  }
}
