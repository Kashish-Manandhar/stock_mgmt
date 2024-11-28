import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/core/constants/constants.dart';

part 'categories_model.g.dart';

part 'categories_model.freezed.dart';

@freezed
class CategoriesModel with _$CategoriesModel {
  const factory CategoriesModel({
    required String categoryId,
    required String categoryName,
    required int createdAt,
    required AvailableSize availableSize,
  }) = _CategoriesModel;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);
}
