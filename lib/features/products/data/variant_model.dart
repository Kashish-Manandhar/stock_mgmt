import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant_model.freezed.dart';

part 'variant_model.g.dart';

@freezed
class VariantColorSizeModel with _$VariantColorSizeModel {
  const factory VariantColorSizeModel(
          {int? color,
          @Default([]) List<VariantSizeQuantity> availableSizeWithQuantity}) =
      _VariantColorSizeModel;

  factory VariantColorSizeModel.fromJson(Map<String, dynamic> json) =>
      _$VariantColorSizeModelFromJson(json);
}

@freezed
class VariantSizeQuantity with _$VariantSizeQuantity {
  const factory VariantSizeQuantity({String? size, @Default(1) int quantity}) =
      _VariantSizeQuantity;

  factory VariantSizeQuantity.fromJson(Map<String, dynamic> json) =>
      _$VariantSizeQuantityFromJson(json);
}
