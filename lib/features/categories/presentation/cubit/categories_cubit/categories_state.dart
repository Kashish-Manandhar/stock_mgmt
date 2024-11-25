import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default([]) List<CategoriesModel> categoryList,
    @Default(false) bool isFromFirebase,
  }) = _CategoriesState;
}
