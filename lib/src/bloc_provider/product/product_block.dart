import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/product/product_event.dart';
import 'package:paropkar/src/bloc_provider/product/product_state.dart';
import 'package:paropkar/src/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  ProductBloc(this.repository) : super(ProductLoading()) {
    on<FetchProducts>(_onFetchProducts);
  }
  void _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productData = await repository.fetchProducts();
      print('if data fetched');
      emit(ProductSuccess(productData));
    } catch (error) {
      emit(ProductFailure(error.toString()));
    }
  }
}
