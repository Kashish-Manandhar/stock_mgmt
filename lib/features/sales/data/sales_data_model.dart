import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import '../../products/data/product_model.dart';

part 'sales_data_model.freezed.dart';

part 'sales_data_model.g.dart';

@freezed
class SalesDataModel with _$SalesDataModel {
  const factory SalesDataModel({
    CategoriesModel? category,
    Product? product,
    int? quantity,
    double? price,
  }) = _SalesDataModel;

  factory SalesDataModel.fromJson(Map<String, dynamic> json) =>
      _$SalesDataModelFromJson(json);
}
