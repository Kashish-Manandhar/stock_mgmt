import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/features/products/data/product_model.dart';

class ProductResponseModel {
  const ProductResponseModel({
    this.productList = const [],
    this.snapshot,
    this.hasMoreData = false,
  });

  final List<Product> productList;
  final QueryDocumentSnapshot? snapshot;
  final bool hasMoreData;
}
