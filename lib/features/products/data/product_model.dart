import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String productCode,
    required Map<String, dynamic> category,
    required String productName,
    required double price,
    required Map<String, dynamic> availableSizeWithQuantity,
    required int createdTimeStamp,
    int? updatedTimeStamp,
    required String productImage,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
