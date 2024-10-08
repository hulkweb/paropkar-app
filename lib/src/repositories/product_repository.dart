import 'package:paropkar/src/models/product/product_detail_model.dart';
import 'package:paropkar/src/models/product/product_listing_model.dart';
import 'package:paropkar/src/services_new/get_http_request.dart';
import 'package:paropkar/src/utills/constants.dart';

class ProductRepository{
   Future<ProductListModel> fetchProducts() async {
    try {
      var response = await getHttpRequest(
        url: AppUrl.product,
      );
      return ProductListModel.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }

   Future<ProductDetailModel> fetchProductDetail(String productId) async {
    try {
      var response = await getHttpRequest(
        url: AppUrl.get_single_product,
      );
      return ProductDetailModel.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }


}