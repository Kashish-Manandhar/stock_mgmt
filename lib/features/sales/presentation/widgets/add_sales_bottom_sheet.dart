import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/widgets/quantity_field_with_incrementer.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_cubit.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_state.dart';
import 'package:stock_management/features/sales/presentation/widgets/product_type_ahead.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../categories/domain/categories_model.dart';

class AddSalesBottomSheet extends StatefulWidget {
  const AddSalesBottomSheet({super.key});

  @override
  State<AddSalesBottomSheet> createState() => _AddSalesBottomSheetState();
}

class _AddSalesBottomSheetState extends State<AddSalesBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddSalesFormCubit, AddSalesFormState>(
      listener: (context, state) {
        state.successState.mapOrNull(
          success: (success) {
            context.maybePop((success.salesModel, success.product));
          },
        );
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: BlocSelector<AddSalesFormCubit, AddSalesFormState, bool>(
              selector: (state) => state.fetchProduct,
              builder: (context, state) {
                return state
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
                              builder: (context, state) {
                            return CustomDropdownField<CategoriesModel>(
                                labelText: 'Category',
                                initialValue: state.selectedCategory,
                                onChanged: (val) => context
                                    .read<AddSalesFormCubit>()
                                    .onChangeCategory(val!),
                                items: context
                                        .read<AddSalesFormCubit>()
                                        .categoriesList
                                        .isEmpty
                                    ? []
                                    : context
                                        .read<AddSalesFormCubit>()
                                        .categoriesList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.categoryName),
                                            ))
                                        .toList(),
                                validator: (val) {
                                  if (val == null) return 'Required';
                                  return null;
                                });
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Product Code'),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
                              builder: (context, state) {
                            return ProductTypeAhead(
                              categoryId: state.selectedCategory?.categoryId,
                              product: state.selectedProduct,
                              onProductSelected: (val) => context
                                  .read<AddSalesFormCubit>()
                                  .onChangeProduct(val),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
                              builder: (context, state) {
                            if (state.selectedProduct?.variantList.isNotEmpty ??
                                false) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: state.selectedProduct?.variantList
                                        .map((element) {
                                      List<VariantColorSizeModel>
                                          selectedSizeWithColorList =
                                          state.selectedVariantList;

                                      List<VariantSizeQuantity>
                                          variantListSize =
                                          element.availableSizeWithQuantity;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Color(element.color!),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: variantListSize.map((e) {
                                              final isSelected =
                                                  selectedSizeWithColorList.any(
                                                      (selectedSizeWithColor) =>
                                                          selectedSizeWithColor
                                                                  .color ==
                                                              element.color &&
                                                          selectedSizeWithColor
                                                              .availableSizeWithQuantity
                                                              .any((size) =>
                                                                  size.size ==
                                                                  e.size));

                                              final maxQuantity = state
                                                  .selectedProduct?.variantList
                                                  .firstWhere((colorList) =>
                                                      colorList.color ==
                                                      element.color)
                                                  .availableSizeWithQuantity
                                                  .firstWhere((size) =>
                                                      size.size == e.size)
                                                  .quantity;

                                              return e.quantity == 0
                                                  ? Text(
                                                      '${e.size} - Stock finished')
                                                  : Column(
                                                      children: [
                                                        CheckboxListTile(
                                                          value: isSelected,
                                                          onChanged: (_) => context
                                                              .read<
                                                                  AddSalesFormCubit>()
                                                              .onSelectSize(
                                                                  element
                                                                      .color!,
                                                                  e.size!),
                                                          title: Text(e.size!),
                                                        ),
                                                        if (isSelected)
                                                          QuantityFieldWithIncrementer(
                                                            onDecrementButtonPressed:
                                                                (quantity) => context
                                                                    .read<
                                                                        AddSalesFormCubit>()
                                                                    .onChangeQuantity(
                                                                        element
                                                                            .color!,
                                                                        e.size!,
                                                                        quantity),
                                                            onIncrementButtonPressed:
                                                                (quantity) => context
                                                                    .read<
                                                                        AddSalesFormCubit>()
                                                                    .onChangeQuantity(
                                                                        element
                                                                            .color!,
                                                                        e.size!,
                                                                        quantity),
                                                            onQuantityChanged:
                                                                (quantity) => context
                                                                    .read<
                                                                        AddSalesFormCubit>()
                                                                    .onChangeQuantity(
                                                                        element
                                                                            .color!,
                                                                        e.size!,
                                                                        quantity),
                                                            quantity:
                                                                maxQuantity,
                                                            maxQuantity:
                                                                maxQuantity,
                                                          )
                                                      ],
                                                    );
                                            }).toList(),
                                          )
                                        ],
                                      );
                                    }).toList() ??
                                    [],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
                              builder: (context, state) {
                            return CustomTextFormField(
                              labelText: 'Selling Price',
                              initialValue: state.price?.toString() ?? '',
                              onChanged: (val) => context
                                  .read<AddSalesFormCubit>()
                                  .onChangePrice(val!),
                              validators: (val) {
                                final productPrice =
                                    state.selectedProduct?.price ?? 0;
                                if (val != null && val.isEmpty) {
                                  return 'Required';
                                } else {
                                  double price =
                                      double.tryParse(val ?? '') ?? 0;
                                  if (price < productPrice) {
                                    return 'Price must be greater than or equal to the cost price';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Builder(builder: (context) {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context
                                      .read<AddSalesFormCubit>()
                                      .onAddSalesProduct();
                                }
                              },
                              child: const Text('Add Product for sales'),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
