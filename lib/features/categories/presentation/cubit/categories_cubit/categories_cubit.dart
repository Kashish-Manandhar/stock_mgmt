import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/data/categories_data_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
    this.categoriesDataSource,
  ) : super(const CategoriesState());
  final CategoriesDataSource categoriesDataSource;

  @postConstruct
  void fetchCategoryList() async {
    try {
      List<CategoriesModel> categoryList = [];

      categoryList = await categoriesDataSource.getCategories();

      emit(
        state.copyWith(categoryList: categoryList),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addCategoryModel(CategoriesModel model) {
    List<CategoriesModel> categoriesList = state.categoryList.toList();

    categoriesList.insert(0, model);

    emit(
      state.copyWith(categoryList: categoriesList),
    );
  }

  void updateCategoryModel(CategoriesModel model) {
    emit(
      state.copyWith(
          categoryList: state.categoryList.map((e) {
        if (e.categoryId == model.categoryId) return model;
        return e;
      }).toList()),
    );
  }

  void searchCategoryList(String search) async {
    try {
      List<CategoriesModel> categoryList = [];
      if (categoryList.isEmpty) {
        emit(state.copyWith(isFromFirebase: true));
        categoryList = await categoriesDataSource.getCategories();
      }

      emit(
        state.copyWith(categoryList: categoryList, isFromFirebase: false),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
