import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';

import '../../products/data/product_model.dart';

@injectable
class SalesDataSource {
  SalesDataSource(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Future<void> addSalesToFireStore(SalesDataModel salesDataModel) async {
    try {
      _firebaseFirestore.runTransaction(
        (transaction) async {
          List<Product> productList =
              salesDataModel.selectedProductList.map((product) {
            if (salesDataModel.saleItemList.any(
                (saleItem) => saleItem.productCode == product.productCode)) {
              List<VariantColorSizeModel> selectedVariantList = salesDataModel
                  .saleItemList
                  .firstWhere(
                      (saleItem) => saleItem.productCode == product.productCode)
                  .selectedVariantList;

              return product.copyWith(
                  variantList: product.variantList.map((variant) {
                if (selectedVariantList.any((selectedVariant) =>
                    selectedVariant.color == variant.color)) {
                  List<VariantSizeQuantity> selectedSizeList =
                      selectedVariantList
                          .firstWhere((selectedVariant) =>
                              selectedVariant.color == variant.color)
                          .availableSizeWithQuantity;
                  return variant.copyWith(
                      availableSizeWithQuantity:
                          variant.availableSizeWithQuantity.map((size) {
                    if (selectedSizeList.any(
                        (selectedSize) => selectedSize.size == size.size)) {
                      final selectedQuantity = selectedSizeList
                          .firstWhere(
                              (selectedSize) => selectedSize.size == size.size)
                          .quantity;

                      return size.copyWith(
                          quantity: size.quantity - selectedQuantity);
                    }
                    return size;
                  }).toList());
                }
                return variant;
              }).toList());
            }

            return product;
          }).toList();

          await _firebaseFirestore.collection('sales').add(
                salesDataModel.toJson()..remove('selectedProductList'),
              );

          for (final product in productList) {
            await _firebaseFirestore
                .collection('products')
                .doc(product.productCode)
                .update(product.toJson());
          }
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SalesResponseModel> getProducts(
      {DateTime? startTime, DateTime? endTime}) async {
    try {
      late Query<Map<String, dynamic>> query;

      if (startTime != null && endTime != null) {
        query = _firebaseFirestore
            .collection('sales')
            .orderBy(
              'createdTime',
              descending: true,
            )
            .where(
              'createdTime',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startTime),
            )
            .where('createdTime',
                isLessThan: Timestamp.fromDate(
                  endTime,
                ))
            .limit(10);
      } else {
        query = _firebaseFirestore
            .collection('sales')
            .orderBy(
              'createdTime',
              descending: true,
            )
            .limit(10);
      }

      final list = await query.get();

      return SalesResponseModel(
          salesList: list.docs
              .map(
                (element) => SalesDataModel.fromJson(
                  element.data(),
                ),
              )
              .toList(),
          snapshot: list.docs.isEmpty ? null : list.docs.last,
          hasMoreData: list.docs.length == 10);
    } catch (e) {
      throw (
        Exception(
          e.toString(),
        ),
      );
    }
  }

  Future<SalesResponseModel> getMoreProducts({
    required QueryDocumentSnapshot snapshot,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    try {
      late Query<Map<String, dynamic>> query;

      if (startTime != null && endTime != null) {
        query = _firebaseFirestore
            .collection('sales')
            .orderBy(
              'createdTime',
              descending: true,
            )
            .where(
              'createdTime',
              isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                  startTime.millisecondsSinceEpoch),
            )
            .where('createdTime',
                isLessThan: Timestamp.fromMicrosecondsSinceEpoch(
                  endTime.millisecondsSinceEpoch,
                ))
            .limit(10);
      } else {
        query = _firebaseFirestore
            .collection('sales')
            .orderBy(
              'createdTime',
              descending: true,
            )
            .limit(10);
      }

      final list = await query.get();
      return SalesResponseModel(
          salesList: list.docs
              .map(
                (element) => SalesDataModel.fromJson(
                  element.data(),
                ),
              )
              .toList(),
          snapshot: list.docs.isEmpty ? null : list.docs.last,
          hasMoreData: list.docs.length == 10);
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
