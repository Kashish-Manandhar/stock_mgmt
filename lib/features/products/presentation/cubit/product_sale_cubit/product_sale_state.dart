import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/variant_model.dart';

part 'product_sale_state.freezed.dart';

@freezed
class ProductSaleState with _$ProductSaleState {
  const factory ProductSaleState({
    @Default([]) List<VariantColorSizeModel> variantList,
    String? note,
    double? price,
    @Default(ProductSaleLoadingState.initial())
    ProductSaleLoadingState loadingState,
  }) = _ProductSaleState;
}

@freezed
class ProductSaleLoadingState with _$ProductSaleLoadingState {
  const factory ProductSaleLoadingState.initial() = _InitialState;

  const factory ProductSaleLoadingState.loading() = _LoadingState;

  const factory ProductSaleLoadingState.success() = _SuccessState;

  const factory ProductSaleLoadingState.error() = _ErrorState;
}
