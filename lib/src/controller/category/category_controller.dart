// For jsonDecode
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/category/category_listing_models.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/utills/constants.dart';

class CategoryListingController extends ChangeNotifier {
  CategoryListingController() {
    getCategories();
  }
  CategoriesListModel? categoryData;
  DataStatus _categoryDataStatus = DataStatus.loading;
  DataStatus get categoryDataStatus => _categoryDataStatus;
  changeDataStatus(DataStatus status) {
    _categoryDataStatus = status;
    notifyListeners();
  }

  getCategories() {
    getApi(
      url: AppUrl.category,
      header: {'Accept': 'application/json'},
      onSuccess: (response) {
        categoryData = CategoriesListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {},
    );
  }
}
