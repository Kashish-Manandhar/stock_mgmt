import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/data/categories_data_source.dart';
import 'package:stock_management/features/categories/data/categories_local_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_state.dart';
import 'package:uuid/v4.dart';

@injectable
class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit(
    this._categoriesLocalSource,
    this._categoriesDataSource,
  ) : super(
          const AddCategoryState(),
        );
  final CategoriesLocalSource _categoriesLocalSource;
  final CategoriesDataSource _categoriesDataSource;

  void onChangeCategoryName(String? categoryName) =>
      emit(state.copyWith(categoryName: categoryName));

  void onAddCategory() async {
    emit(
      state.copyWith(
        loadingState: const AddCategoryLoadingState.loading(),
      ),
    );

    final categoryModel = CategoriesModel(
      categoryId: const UuidV4().generate(),
      categoryName: state.categoryName ?? '',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await _categoriesLocalSource.addCategory(categoryModel);
      await _categoriesDataSource.addCategories(categoryModel);

      emit(
        state.copyWith(
          loadingState: AddCategoryLoadingState.success(categoryModel),
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
}
