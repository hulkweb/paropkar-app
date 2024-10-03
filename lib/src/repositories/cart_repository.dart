import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/services_new/get_http_request.dart';
import 'package:paropkar/src/services_new/post_http_request.dart';
import 'package:paropkar/src/utills/constants.dart';

class CartRepository {
  Future<CartModel> fetchCart() async {
    var response = await getHttpRequest(
      url: AppUrl.carts,
    );
    return CartModel.fromJson(response);
  }

 // Add item from cart API call
  Future<bool> addCartItem({
    required String productId,
  }) async {
    var response = await postHttpRequest(url: 'add', fields: {});
    return response['success'];
  }

  // Remove item from cart API call
  Future<bool> removeCartItem({
    required String productId,
  }) async {
    var response = await postHttpRequest(url: 'remove', fields: {});
    return response['success'];
  }
}
