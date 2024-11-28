import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/products/data/variant_model.dart';

part 'variant_state.freezed.dart';

@freezed
class VariantState with _$VariantState {
  const factory VariantState({
    @Default(VariantModel()) VariantModel variantModel,
  }) = _VariantState;
}
