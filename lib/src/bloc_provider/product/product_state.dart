import 'package:paropkar/src/models/product/product_detail_model.dart';
import 'package:paropkar/src/models/product/product_listing_model.dart';

abstract class ProductState {}

class ProductListingLoading extends ProductState {}

class ProductListingSuccess extends ProductState {
   final ProductListModel productListData;
   ProductListingSuccess(this.productListData);
}

class ProductListingFailure extends ProductState {
  final String errorMessage;
  ProductListingFailure(this.errorMessage);
}

class ProductDetailLoading extends ProductState {}

class ProductDetailSuccess extends ProductState {
   final ProductDetailModel productDetailData;
   ProductDetailSuccess(this.productDetailData);
}

class ProductDetailFailure extends ProductState {
  final String errorMessage;
  ProductDetailFailure(this.errorMessage);
}
