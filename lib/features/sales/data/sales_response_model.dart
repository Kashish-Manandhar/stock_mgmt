import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';

class SalesResponseModel {
  const SalesResponseModel({
    this.salesList = const [],
    this.snapshot,
    this.hasMoreData = false,
  });

  final List<SalesDataModel> salesList;
  final QueryDocumentSnapshot? snapshot;
  final bool hasMoreData;
}
