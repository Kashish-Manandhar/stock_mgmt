import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/core/widgets/quantity_field_with_incrementer.dart';
import 'package:stock_management/features/products/presentation/cubit/product_sale_cubit/product_sale_cubit.dart';
import 'package:stock_management/features/products/presentation/cubit/product_sale_cubit/product_sale_state.dart';

import '../../data/product_model.dart';

class SaleProductBottomSheet extends StatelessWidget {
  const SaleProductBottomSheet({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductSaleCubit, ProductSaleState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.variantList
                  .map(
                    (element) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Color(element.color!),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Column(
                            children:
                                element.availableSizeWithQuantity.map((e) {
                          bool isSelected = state.variantList.any((variant) {
                            if (variant.color == element.color) {
                              if (variant.availableSizeWithQuantity
                                  .any((size) => size.size == e.size)) {
                                return true;
                              }
                              return false;
                            }
                            return false;
                          });

                          int? maxQuantity = product.variantList
                              .firstWhere(
                                  (variant) => variant.color == element.color)
                              .availableSizeWithQuantity
                              .firstWhere((size) => size.size == e.size)
                              .quantity;

                          return Column(
                            children: [
                              CheckboxListTile(
                                value: isSelected,
                                onChanged: (_) => context
                                    .read<ProductSaleCubit>()
                                    .onSelectSize(element.color!, e.size!),
                                title: Text(e.size ?? ''),
                              ),
                              if (isSelected)
                                QuantityFieldWithIncrementer(
                                  onDecrementButtonPressed: (quantity) =>
                                      context
                                          .read<ProductSaleCubit>()
                                          .onChangeQuantity(element.color!,
                                              e.size!, quantity),
                                  onIncrementButtonPressed: (quantity) =>
                                      context
                                          .read<ProductSaleCubit>()
                                          .onChangeQuantity(element.color!,
                                              e.size!, quantity),
                                  onQuantityChanged: (quantity) => context
                                      .read<ProductSaleCubit>()
                                      .onChangeQuantity(
                                          element.color!, e.size!, quantity),
                                  quantity: e.quantity,
                                  maxQuantity: maxQuantity,
                                )
                            ],
                          );
                        }).toList())
                      ],
                    ),
                  )
                  .toList(),
            );
          }),
          const SizedBox(
            height: 20,
          ),
          Builder(builder: (context) {
            return CustomTextFormField(
              labelText: 'Note',
              onChanged: context.read<ProductSaleCubit>().onChangeNote,
              maxLines: 5,
            );
          }),
          const SizedBox(
            height: 20,
          ),
          Builder(builder: (context) {
            return CustomTextFormField(
              labelText: 'Price',
              onChanged: context.read<ProductSaleCubit>().onChangePrice,
            );
          }),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductSaleCubit, ProductSaleState>(
              builder: (context, state) {
            return ElevatedButton(
              onPressed: () => context.read<ProductSaleCubit>().onAddSales(),
              child: state.loadingState.maybeWhen(
                orElse: () => const Text('Add to sale'),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
