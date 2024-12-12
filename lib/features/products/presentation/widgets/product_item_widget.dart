import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/products/data/product_model.dart';

import '../../../../core/auto_route/app_router.gr.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.navigate(
        ProductDetailRoute(
          product: product,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(product.productCode)),
                const Icon(Icons.chevron_right),
              ],
            ),
            const Divider(
              height: 4,
            ),
            Text(product.productName),
            Text(context
                .read<CategoriesCubit>()
                .state
                .categoryList
                .firstWhere(
                    (category) => category.categoryId == product.categoryId)
                .categoryName),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const Text('Available Colors:'),
            //             Wrap(
            //               spacing: 10,
            //               children: product.variantList.map((variant) {
            //                 return Container(
            //                   height: 20,
            //                   width: 20,
            //                   decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: Color(variant.color!)),
            //                 );
            //               }).toList(),
            //             ),
            //           ]),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text('Available Sizes:'),
            //           Wrap(
            //             children: _availableSizes
            //                 .map((e) => Container(
            //
            //                     padding: const EdgeInsets.all(4),
            //                     decoration: BoxDecoration(
            //                         border: Border.all(color: Colors.black)),
            //                     child: Text(e,style: TextStyle(fontSize: 8),)))
            //                 .toList(),
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total quantity: $_totalQuantity'),
                Text('Price : Rs ${product.price}'),
              ],
            )
          ],
        ),
      ),
    );
  }

  int get _totalQuantity {
    int quantity = 0;

    for (final variant in product.variantList) {
      quantity += variant.availableSizeWithQuantity.fold(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );
    }

    return quantity;
  }


}
