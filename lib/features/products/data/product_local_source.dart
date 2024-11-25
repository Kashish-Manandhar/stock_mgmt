import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/constants/hive_constants.dart';
import 'package:stock_management/features/products/data/product_model.dart';

@lazySingleton
class ProductLocalSource {
  ProductLocalSource();

  final Box<Product> _productBox = Hive.box<Product>(HiveConstants.productBox);

  Future<void> addProduct(Product product) async {
    final result = await _productBox.add(product);
    print(result);
  }

  List<Product> getItems() => _productBox.values.toList();

  void removeItem(int index) => _productBox.deleteAt(index);
}
