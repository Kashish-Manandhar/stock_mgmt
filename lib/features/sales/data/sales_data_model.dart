import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';

part 'sales_data_model.freezed.dart';

part 'sales_data_model.g.dart';

@freezed
class SalesDataModel with _$SalesDataModel {
  const factory SalesDataModel({
    @Default([]) List<SalesProductModel> saleItemList,
    String? note,
    double? totalPrice,
  }) = _SalesDataModel;

  factory SalesDataModel.fromJson(Map<String, dynamic> json) =>
      _$SalesDataModelFromJson(json);
}
