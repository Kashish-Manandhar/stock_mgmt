import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant_model.freezed.dart';

part 'variant_model.g.dart';

@freezed
class VariantModel with _$VariantModel {
  const factory VariantModel({String? size, int? color, int? quantity}) =
      _VariantModel;

  factory VariantModel.fromJson(Map<String, dynamic> json) =>
      _$VariantModelFromJson(json);
}
