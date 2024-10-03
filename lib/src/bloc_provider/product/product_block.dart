// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paropkar/src/bloc_provider/product/product_state.dart';
// import 'package:paropkar/src/bloc_provider/product/product_event.dart';
// import 'package:paropkar/src/repositories/product_repository.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository repository;
  
//   ProductBloc(this.repository) : super(ProductListingLoading()) {
//     on<FetchProducts>(_onFetchProductListings);
//     on<FetchProductDetail>(_onFetchProductDetail
//         as EventHandler<FetchProductDetail, ProductState>);
//   }
//   void _onFetchProductListings(
//       FetchProducts event, Emitter<ProductState> emit) async {
//     emit(ProductListingLoading());
//     try {
//       final productData = await repository.fetchProducts();
//       print('if data fetched');
//       emit(ProductListingSuccess(productData));
//     } catch (error) {
//       emit(ProductListingFailure(error.toString()));
//     }
//   }

//   void _onFetchProductDetail(FetchProducts event, Emitter<ProductState> emit,
//       {required String productId}) async {
//     emit(ProductListingLoading());
//     try {
//       final productData = await repository.fetchProductDetail(productId);
//       print('if data fetched');
//       emit(ProductDetailSuccess(productData));
//     } catch (error) {
//       emit(ProductListingFailure(error.toString()));
//     }
//   }
// }
