import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/constants/hive_constants.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

@injectable
class CategoriesLocalSource {
  CategoriesLocalSource();

  final Box<CategoriesModel> _categoriesBox =
      Hive.box<CategoriesModel>(HiveConstants.categoryBox);

  Future<void> addCategory(CategoriesModel category) async {
    try {
      final result = await _categoriesBox.add(category);

      print(result);
    } catch (e) {
      print(e);
    }
  }

  List<CategoriesModel> getCategoriesList({String? query}) =>
      _categoriesBox.values
          .toList()
          .where((value) => value.categoryName.startsWith(query ?? ''))
          .toList();
}
