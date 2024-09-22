import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/Cart/Cart_event.dart';
import 'package:paropkar/src/bloc_provider/Cart/Cart_state.dart';
import 'package:paropkar/src/models/category/category_listing_models.dart';
import 'package:paropkar/src/repositories/Cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartLoading()) {
    print('fetching the Cart');
    on<FetchCart>(_onFetchCart);
  }
  void _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartData = await repository.fetchCart();
      print('if data fetched');
      emit(CartSuccess(cartData as CategoriesListModel));
      print('emit state Cart success');
    } catch (error) {
      emit(CartFailure(error.toString()));
      print('emit state Cart error');
    }
  }
}
