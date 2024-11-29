import 'package:flutter/material.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/widgets/custom_typeahead_field.dart';
import '../../../products/data/product_data_source.dart';
import '../../../products/data/product_model.dart';

class ProductTypeAhead extends StatefulWidget {
  const ProductTypeAhead(
      {super.key, this.salesProductModel, this.onProductSelected});

  final SalesProductModel? salesProductModel;
  final Function(Product)? onProductSelected;

  @override
  State<ProductTypeAhead> createState() => _ProductTypeAheadState();
}

class _ProductTypeAheadState extends State<ProductTypeAhead> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTypeAheadField<Product>(
      textEditingController: textEditingController,
      itemBuilder: (_, value) {
        return Text(value.productCode);
      },
      suggestionsCallback: (search) {
        if (search.isNotEmpty) {
          return getIt<ProductDataSource>().searchProduct(
            search: search,
            category: widget.salesProductModel?.categoriesModel,
          );
        }
        return [];
      },
      onSelected: (val) {
        textEditingController.text = val.productCode;
        widget.onProductSelected?.call(val);
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
