import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/products/data/variant_model.dart';

class VariantModelConverter
    extends JsonConverter<VariantModel, Map<String, dynamic>> {
  @override
  VariantModel fromJson(Map<String, dynamic> json) =>
      VariantModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(VariantModel object) => object.toJson();
}
