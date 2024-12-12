import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';

@RoutePage()
class SaleDetailScreen extends StatelessWidget {
  const SaleDetailScreen({super.key, required this.salesDataModel});

  final SalesDataModel salesDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: salesDataModel.saleItemList
                  .map((saleItem) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Code : ${saleItem.productCode}'),
                          Text(
                              'Category Name : ${context.read<CategoriesCubit>().state.categoryList.firstWhere((category) => category.categoryId == saleItem.categoryId).categoryName}'),
                          Column(
                            children: saleItem.selectedVariantList
                                .map(
                                  (variant) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color(variant.color!)),
                                      ),
                                      Column(
                                        children: variant
                                            .availableSizeWithQuantity
                                            .map((size) => Row(
                                                  children: [
                                                    Text('Size: ${size.size} '),
                                                    Text(
                                                        'Quantity : ${size.quantity}')
                                                  ],
                                                ))
                                            .toList(),
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ))
                  .toList(),
            ),
            Text('Notes: ${salesDataModel.note}'),
            Text('Total Price: ${salesDataModel.totalPrice}'),
          ],
        ),
      ),
    );
  }
}
