
import 'package:paropkar/src/models/cart/cart_model.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartModel cartData;
  CartSuccess(this.cartData);
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure(this.errorMessage);
}
