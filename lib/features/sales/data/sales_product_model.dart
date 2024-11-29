import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import '../../products/data/product_model.dart';
import '../../products/data/variant_model.dart';

part 'sales_product_model.freezed.dart';

part 'sales_product_model.g.dart';

@freezed
class SalesProductModel with _$SalesProductModel {
  const factory SalesProductModel({
    double? price,
    CategoriesModel? categoriesModel,
    Product? product,
    @Default([]) List<VariantModel> selectedVariantList,
  }) = _SalesProductModel;

  factory SalesProductModel.fromJson(Map<String, dynamic> json) =>
      _$SalesProductModelFromJson(json);
}
