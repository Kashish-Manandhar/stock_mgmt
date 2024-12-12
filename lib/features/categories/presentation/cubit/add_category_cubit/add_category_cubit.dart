import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/constants/constants.dart';
import 'package:stock_management/features/categories/data/categories_data_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_state.dart';
import 'package:uuid/v4.dart';

@injectable
class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit(
    this._categoriesDataSource,
  ) : super(
          const AddCategoryState(),
        );
  final CategoriesDataSource _categoriesDataSource;

  void onChangeCategoryName(String? categoryName) =>
      emit(state.copyWith(categoryName: categoryName));

  void onChangeAvailableSize(AvailableSize? availableSize) => emit(
      state.copyWith(availableSize: availableSize ?? AvailableSize.alphaSize));

  void onAddCategory() async {
    emit(
      state.copyWith(
        loadingState: const AddCategoryLoadingState.loading(),
      ),
    );

    final categoryModel = CategoriesModel(
      categoryId:
          state.categoriesModel?.categoryId ?? const UuidV4().generate(),
      categoryName: state.categoryName ?? '',
      createdAt: state.categoriesModel?.createdAt ??
          DateTime.now().millisecondsSinceEpoch,
      availableSize: state.availableSize,
    );

    try {
      debugPrint('${categoryModel.toJson()}');

      await _categoriesDataSource.addCategories(
        categoryModel,
        isEdit: state.categoriesModel != null,
      );

      emit(
        state.copyWith(
          loadingState: AddCategoryLoadingState.success(
            categoryModel,
            state.categoriesModel != null,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: const AddCategoryLoadingState.error(),
        ),
      );
    }
  }

  void initCategory(CategoriesModel category) {
    emit(
      state.copyWith(
          categoryName: category.categoryName,
          availableSize: category.availableSize,
          categoriesModel: category),
    );
  }
}
