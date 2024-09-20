import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/product/product_detail_model.dart';
import 'package:paropkar/src/services/get_api.dart';
// For jsonDecode
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
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

   ProductDetailModel? productDetailData;
  DataStatus _productDetailDataStatus = DataStatus.loading;
  DataStatus get productDetailDataStatus => _productDetailDataStatus;
  changeDataStatus(DataStatus status){
    _productDetailDataStatus = status;
    print('status changed $status');
    notifyListeners();
  }

  getProductDetail({required String id}) {
    changeDataStatus(DataStatus.loading);
    getApi(
      url: '${AppUrl.get_single_product}/$id',
      header: {'Accept': 'application/json'},
      onSuccess: (response) {
        productDetailData = ProductDetailModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeDataStatus(DataStatus.error);

      },
    );
  }
}