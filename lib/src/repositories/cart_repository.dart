import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/services_new/get_http_request.dart';
import 'package:paropkar/src/utills/constants.dart';

class CartRepository {
  Future<CartModel> fetchCart() async {
    try {
      var response = await getHttpRequest(
        url: AppUrl.carts,
      );
      return CartModel.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}