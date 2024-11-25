import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

part 'add_category_state.freezed.dart';

@freezed
class AddCategoryState with _$AddCategoryState {
  const factory AddCategoryState({
    String? categoryName,
    @Default(AddCategoryLoadingState.initial())
    AddCategoryLoadingState loadingState,
  }) = _AddCategoryState;
}

@freezed
class AddCategoryLoadingState with _$AddCategoryLoadingState {
  const factory AddCategoryLoadingState.initial() = _InitialState;

  const factory AddCategoryLoadingState.loading() = _LoadingState;

  const factory AddCategoryLoadingState.success(CategoriesModel categoryModel) =
      _SuccessState;

  const factory AddCategoryLoadingState.error() = _ErrorState;
}
