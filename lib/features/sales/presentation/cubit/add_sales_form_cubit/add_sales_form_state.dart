import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';

import '../../../../categories/domain/categories_model.dart';
import '../../../../products/data/product_model.dart';
import '../../../../products/data/variant_model.dart';

part 'add_sales_form_state.freezed.dart';

@freezed
class AddSalesFormState with _$AddSalesFormState {
  const factory AddSalesFormState({
    CategoriesModel? selectedCategory,
    double? price,
    Product? selectedProduct,
    @Default([]) List<VariantColorSizeModel> selectedVariantList,
    @Default(AddSalesFormSuccessState.initial())
    AddSalesFormSuccessState successState,
    @Default(false) bool fetchProduct,
  }) = _AddSalesFormState;
}

@freezed
class AddSalesFormSuccessState with _$AddSalesFormSuccessState {
  const factory AddSalesFormSuccessState.initial() = _AddSalesFormInitialState;

  const factory AddSalesFormSuccessState.success(
          SalesProductModel salesModel, Product product) =
      _AddSalesFormSuccessState;
}
