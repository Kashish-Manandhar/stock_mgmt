import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';
import 'package:stock_management/core/constants/constants.dart';

import '../../data/product_model.dart';

@RoutePage()
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  context.router.navigate(AddProductsRoute(product: product)),
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.productCode),
            Text(product.productName),
            Text('Rs ${product.price}'),
            const Text('Available Sizes'),
            ...product.variantList.map((availableSize) {
              return Row(
                children: [
                  Text('${_getString(availableSize.size ?? '')} : '),
                  Text(availableSize.quantity?.toString() ?? ''),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getString(String availableSize) {
    switch (availableSize) {
      case 'S':
        return 'Small';
      case 'M':
        return 'Medium';
      case 'L':
        return 'Large';
      case 'XL':
        return 'Extra large';
      case 'XXL':
        return 'Double XL';
      case 'XXXL':
        return 'Triple XL';
      default:
        return availableSize;
    }
  }
}
