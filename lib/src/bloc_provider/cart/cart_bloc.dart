import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/Cart/Cart_event.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_state.dart';
import 'package:paropkar/src/repositories/Cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartLoading()) {
    on<FetchCart>(_onFetchCart);
  }
  void _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartData = await repository.fetchCart();
      emit(CartSuccess(cartData));
    } catch (error){
      emit(CartFailure(error.toString()));
    }
  }
}