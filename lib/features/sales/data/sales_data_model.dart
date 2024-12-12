import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/products/data/product_model.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';
import 'package:stock_management/features/sales/data/time_stamp_converter.dart';

part 'sales_data_model.freezed.dart';

part 'sales_data_model.g.dart';

@freezed
class SalesDataModel with _$SalesDataModel {
  const factory SalesDataModel({
    @Default([]) List<SalesProductModel> saleItemList,
    @Default([]) List<Product> selectedProductList,
    String? note,
    String? customer,
    double? totalPrice,
    @TimeStampConverter() DateTime? createdTime,
  }) = _SalesDataModel;

  factory SalesDataModel.fromJson(Map<String, dynamic> json) =>
      _$SalesDataModelFromJson(json);
}
