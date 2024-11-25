import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/data/categories_data_source.dart';
import 'package:stock_management/features/categories/data/categories_local_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
    this.categoriesLocalSource,
    this.categoriesDataSource,
  ) : super(const CategoriesState());
  final CategoriesLocalSource categoriesLocalSource;
  final CategoriesDataSource categoriesDataSource;

  @postConstruct
  void fetchCategoryList() async {
    try {
      List<CategoriesModel> categoryList = [];
      categoryList = categoriesLocalSource.getCategoriesList();
      if (categoryList.isEmpty) {
        emit(state.copyWith(isFromFirebase: true));
        categoryList = await categoriesDataSource.getCategories();
      }

      emit(
        state.copyWith(categoryList: categoryList, isFromFirebase: false),
      );
    } catch (e) {}
  }

  void addCategoryModel(CategoriesModel model) {
    List<CategoriesModel> categoriesList = state.categoryList.toList();

    categoriesList.insert(0, model);

    emit(
      state.copyWith(categoryList: categoriesList),
    );
  }

  void searchCategoryList(String search) async {
    try {
      List<CategoriesModel> categoryList = [];
      categoryList = categoriesLocalSource.getCategoriesList();
      if (categoryList.isEmpty) {
        emit(state.copyWith(isFromFirebase: true));
        categoryList = await categoriesDataSource.getCategories();
      }

      emit(
        state.copyWith(categoryList: categoryList, isFromFirebase: false),
      );
    } catch (e) {}
  }
}
