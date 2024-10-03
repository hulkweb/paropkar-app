import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/services_new/get_http_request.dart';
import 'package:paropkar/src/services_new/post_http_request.dart';
import 'package:paropkar/src/utills/constants.dart';

class AuthRepository {
  // Add item from cart API call
  Future<bool> login({
    required String mobile,
    String? otp,
    String? password,
  }) async {
    var response = await postHttpRequest(url: AppUrl.login, fields: {});
    return response['success'];
  }

  // Remove item from cart API call
  Future<bool> mobileVarify({
    required String productId,
  }) async {
    var response = await postHttpRequest(url: 'remove', fields: {});
    return response['success'];
  }

  // Remove item from cart API call
  Future<bool> register({
    required String productId,
  }) async {
    var response = await postHttpRequest(url: 'remove', fields: {});
    return response['success'];
  }

  Future<bool> logout({
    required String productId,
  }) async {
    var response = await postHttpRequest(url: 'remove', fields: {});
    return response['success'];
  }
}
