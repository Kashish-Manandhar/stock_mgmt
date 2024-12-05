import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';

import '../../../../core/di/injector.dart';
import '../../data/product_model.dart';
import '../cubit/product_sale_cubit/product_sale_cubit.dart';
import '../cubit/product_sale_cubit/product_sale_state.dart';
import '../widgets/sale_product_bottom_sheet.dart';

@RoutePage()
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final result = await context.router
                    .push<Product?>(AddProductsRoute(product: widget.product));

                if (result != null) {
                  setState(() {
                    product = result;
                  });
                }
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.productCode),
            Text(widget.product.productName),
            Text('Rs ${widget.product.price}'),
            ...widget.product.variantList.map((availableSize) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(availableSize.color!),
                        shape: BoxShape.circle),
                  ),
                  const Row(
                    children: [
                      Expanded(child: Text('Available Size')),
                      Expanded(child: Text('Quantity'))
                    ],
                  ),
                  Column(
                    children: availableSize.availableSizeWithQuantity
                        .map((value) => Row(
                              children: [
                                Expanded(child: Text(value.size ?? '')),
                                Expanded(child: Text(value.quantity.toString()))
                              ],
                            ))
                        .toList(),
                  )
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Center(child: Text('Add Sales')),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (c) => BlocProvider(
                  create: (_) => getIt<ProductSaleCubit>(
                    param1: product,
                  ),
                  child: BlocListener<ProductSaleCubit, ProductSaleState>(
                    listener: (context, state) {
                      state.loadingState.mapOrNull(success: (_) {
                        c.router.maybePop();
                      });
                    },
                    child: SaleProductBottomSheet(
                      product: widget.product,
                    ),
                  ),
                )),
      ),
    );
  }
}
