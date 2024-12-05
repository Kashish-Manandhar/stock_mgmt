import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/products/data/product_response_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductResponseModel()) ProductResponseModel productResponseModel,
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    String? errorMessage,
  }) = _ProductState;
}
