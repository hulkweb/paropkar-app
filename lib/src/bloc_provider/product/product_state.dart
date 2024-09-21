import 'package:paropkar/src/models/product/product_listing_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
   final ProductListModel productListData;
   ProductSuccess(this.productListData);
}

class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure(this.errorMessage);
}
