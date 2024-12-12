import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';

import '../../../../core/auto_route/app_router.gr.dart';

class SalesItemList extends StatelessWidget {
  const SalesItemList({super.key, required this.salesDataModel});

  final SalesDataModel salesDataModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.navigate(
        SaleDetailRoute(
          salesDataModel: salesDataModel,
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
            children: salesDataModel.saleItemList.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Product Code : ${e.productCode}'),
                      ),
                      Expanded(
                        child: Text('Product Price : ${e.price}'),
                      ),
                    ],
                  ),
                  Wrap(
                    children: e.selectedVariantList
                        .map(
                          (variant) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(variant.color!),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              );
            }).toList()),
      ),
    );
  }
}
