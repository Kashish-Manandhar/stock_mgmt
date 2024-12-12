import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';
import 'package:stock_management/core/extensions/string_extension.dart';
import 'package:stock_management/features/products/data/variant_model.dart';

import '../../../../core/di/injector.dart';
import '../../data/product_model.dart';
import '../cubit/product_cubit/product_cubit.dart';
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
  late int? selectedColor;
  late List<VariantSizeQuantity>? selectedSizeList;
  String? selectedSize;

  @override
  void initState() {
    product = widget.product;
    selectedColor = widget.product.variantList.first.color;
    selectedSizeList = widget.product.variantList
        .firstWhere((variant) => variant.color == selectedColor)
        .availableSizeWithQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productCode),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async {
                final result = await context.router
                    .push<Product?>(AddProductsRoute(product: widget.product));

                if (result != null) {
                  setState(() {
                    product = result;
                  });

                  if (context.mounted) {
                    context.read<ProductCubit>().updateProduct(result);
                  }
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
            Text(
              product.productName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Rs ${product.price}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Available Colors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Wrap(
              children: product.variantList
                  .map(
                    (variant) => InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        setState(() {
                          selectedColor = variant.color;
                          selectedSizeList = variant.availableSizeWithQuantity;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(variant.color!),
                            shape: BoxShape.circle,
                            border: selectedColor == variant.color
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                            boxShadow: selectedColor == variant.color
                                ? [
                                    const BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.2,
                                        blurRadius: 0.8)
                                  ]
                                : null),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Available Sizes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12,
            ),
            ...selectedSizeList?.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e.size.getSizeName(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                            ),
                            Text('Stock : ${e.quantity}')
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList() ??
                []
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Center(widthFactor: 0.6, child: Text('Add Sales')),
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
                        _updateProduct(state.variantList);
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

  _updateProduct(List<VariantColorSizeModel> updatedVariantList) {
    setState(() {
      product = product.copyWith(
          variantList: product.variantList.map((variant) {
        if (updatedVariantList
            .any((updatedVariant) => updatedVariant.color == variant.color)) {
          return variant.copyWith(
              availableSizeWithQuantity:
                  variant.availableSizeWithQuantity.map((size) {
            List<VariantSizeQuantity> updatedSizeList = updatedVariantList
                .firstWhere(
                    (updatedVariant) => updatedVariant.color == variant.color)
                .availableSizeWithQuantity;
            if (updatedSizeList
                .any((updatedSize) => updatedSize.size == size.size)) {
              int quantity = updatedSizeList
                  .firstWhere((updatedSize) => updatedSize.size == size.size)
                  .quantity;

              return size.copyWith(quantity: size.quantity - quantity);
            }
            return size;
          }).toList());
        }
        return variant;
      }).toList());
    });
  }
}
