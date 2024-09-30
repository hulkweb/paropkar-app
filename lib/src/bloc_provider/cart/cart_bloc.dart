// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paropkar/src/bloc_provider/cart/cart_event.dart';
// import 'package:paropkar/src/bloc_provider/cart/cart_state.dart';
// import 'package:paropkar/src/repositories/Cart_repository.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartRepository repository;

//   CartBloc(this.repository) : super(CartLoading()) {
//     on<FetchCart>(_onFetchCart);
//     on<AddCartItem>(_onAddCartItem);
//     on<RemoveCartItem>(_onRemoveCartItem);
//   }

//   // Fetch cart
//   void _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
//     emit(CartLoading());
//     try {
//       final cartData = await repository.fetchCart();
//       emit(CartSuccess(cartData));
//     } catch (error) {
//       emit(CartFailure(error.toString()));
//     }
//   }

//   // Add item to cart
//   void _onAddCartItem(AddCartItem event, Emitter<CartState> emit) async {
//     emit(AddCartLoading());
//     try {
//       await repository.addCartItem(
//         productId: event.productId,
//       );
//       // Fetch updated cart after adding item
//       final cartData = await repository.fetchCart();
//       emit(AddCartSuccess('successfully added'));
//     } catch (error) {
//       emit(AddCartFailure(error.toString()));
//     }
//   }

//   // Remove item from cart
//   void _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
//     emit(RemoveCartLoading());
//     try {
//       await repository.removeCartItem(
//         productId: event.productId,
//       );
//       emit(RemoveCartSuccess());

//       // Fetch updated cart after removing item
//       final cartData = await repository.fetchCart();
//       emit(CartSuccess(cartData));
//     } catch (error) {
//       emit(RemoveCartFailure(error.toString()));
//     }
//   }
// }
