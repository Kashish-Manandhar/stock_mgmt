import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/products/data/variant_model_converter.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';
@freezed
class Product with _$Product {
  const factory Product({
    required String productCode,
    required Map<String, dynamic> category,
    required String productName,
    required double price,
    @Default([]) List<VariantModel> variantList,
    required int createdTimeStamp,
    int? updatedTimeStamp,
    required String productImage,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
