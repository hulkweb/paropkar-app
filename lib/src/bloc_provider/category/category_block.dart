import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/category/category_event.dart';
import 'package:paropkar/src/bloc_provider/category/category_state.dart';
import 'package:paropkar/src/repositories/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryLoading()) {
    print('fetching the category');
    on<FetchCategories>(_onFetchCategories);
  }
  void _onFetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) 
  async {
    emit(CategoryLoading());
    try {
      final categoryData = await repository.fetchCategories();
      print('if data fetched');
      emit(CategorySuccess(categoryData));
      print('emit state category success');
    } catch (error) {
      emit(CategoryFailure(error.toString()));
      print('emit state category error');
    }
  }
}
