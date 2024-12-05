import 'package:freezed_annotation/freezed_annotation.dart';
import '../../products/data/variant_model.dart';

part 'sales_product_model.freezed.dart';

part 'sales_product_model.g.dart';

@freezed
class SalesProductModel with _$SalesProductModel {
  const factory SalesProductModel({
    required double price,
    required String categoryId,
    required String productCode,
    @Default([]) List<VariantColorSizeModel> selectedVariantList,
  }) = _SalesProductModel;

  factory SalesProductModel.fromJson(Map<String, dynamic> json) =>
      _$SalesProductModelFromJson(json);
}
