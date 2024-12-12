import 'package:flutter/material.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/widgets/custom_typeahead_field.dart';
import '../../../products/data/product_data_source.dart';
import '../../../products/data/product_model.dart';

class ProductTypeAhead extends StatefulWidget {
  const ProductTypeAhead({
    super.key,
    this.product,
    this.onProductSelected,
    this.categoryId,
  });

  final Product? product;
  final Function(Product)? onProductSelected;
  final String? categoryId;

  @override
  State<ProductTypeAhead> createState() => _ProductTypeAheadState();
}

class _ProductTypeAheadState extends State<ProductTypeAhead> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.product?.productCode ?? '');
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
            categoryId: widget.categoryId,
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
