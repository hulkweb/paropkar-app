// For jsonDecode
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/category/category_listing_models.dart';
import 'package:paropkar/src/models/category/sub_category_models.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/utills/constants.dart';

class SubCategoryListingController extends ChangeNotifier {
  SubCategoryListingController() {
    getCategories();
  }
  SubCategoriesListModel? subCategoryData;
  DataStatus _subCategoryDataStatus = DataStatus.loading;
  DataStatus get subCategoryDataStatus => _subCategoryDataStatus;
  changeDataStatus(DataStatus status) {
    _subCategoryDataStatus = status;
    notifyListeners();
  }

  getCategories() {
    getApi(
      url: AppUrl.subcategory,
      header: {'Accept': 'application/json'},
      onSuccess: (response){
        subCategoryData = SubCategoriesListModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {},
    );
  }
}
