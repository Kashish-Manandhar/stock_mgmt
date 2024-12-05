import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/extensions/enum_extension.dart';
import 'package:stock_management/core/widgets/custom_dropdown_field.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/core/widgets/quantity_field_with_incrementer.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/products/presentation/cubit/add_product_cubit.dart';
import 'package:stock_management/features/products/presentation/cubit/add_product_state.dart';
import 'package:stock_management/features/products/presentation/widgets/image_holder.dart';

import '../../data/product_model.dart';

@RoutePage()
class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key, this.product});

  final Product? product;

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, categoriesState) {
      return BlocProvider<AddProductCubit>(
        create: (_) => getIt<AddProductCubit>(
          param1: widget.product,
          param2: categoriesState.categoryList,
        ),
        child: BlocListener<AddProductCubit, AddProductState>(
          listener: (context, state) {
            state.addProductLoadingState.mapOrNull(success: (success) {
              context.router.maybePop(state.product);
            }, error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.error.toString(),
                  ),
                ),
              );
            });
          },
          listenWhen: (prev, next) =>
              prev.addProductLoadingState != next.addProductLoadingState,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return ImageHolder(
                        isEditable: true,
                        onSelectImage:
                            context.read<AddProductCubit>().onChangeImage,
                        imageFile: state.imageSelected,
                        imageUrl: state.product.productImage,
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return CustomTextFormField(
                        initialValue: state.product.productCode,
                        labelText: 'Product Code',
                        onChanged:
                            context.read<AddProductCubit>().onChangeProductCode,
                        validators: (val) {
                          if (val != null && val.isEmpty) return 'Required';
                          return null;
                        },
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return CustomTextFormField(
                        initialValue: state.product.productName,
                        labelText: 'Product Name',
                        onChanged:
                            context.read<AddProductCubit>().onChangeProductName,
                        validators: (val) {
                          if (val != null && val.isEmpty) return 'Required';
                          return null;
                        },
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return CustomTextFormField(
                        initialValue: state.product.price.toString(),
                        labelText: 'Price',
                        onChanged: context
                            .read<AddProductCubit>()
                            .onChangeProductPrice,
                        validators: (val) {
                          if (val != null && val.isEmpty) return 'Required';
                          return null;
                        },
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return CustomDropdownField<CategoriesModel>(
                        labelText: 'Categories',
                        initialValue: state.selectedCategory,
                        onChanged:
                            context.read<AddProductCubit>().onChangeCategory,
                        items: categoriesState.isFromFirebase
                            ? []
                            : categoriesState.categoryList.isEmpty
                                ? []
                                : categoriesState.categoryList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.categoryName),
                                        ))
                                    .toList(),
                        validator: (val) {
                          if (val == null) return 'Required';
                          return null;
                        },
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                      builder: (context, state) {
                        if (state.selectedVariant.isEmpty) {
                          return const SizedBox();
                        } else {
                          return Column(
                            children: state.selectedVariant
                                .map((color) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Selected Color : '),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(color.color!),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text('Available Sizes'),
                                        Column(
                                          children: state.selectedCategory
                                                  ?.availableSize
                                                  .getSizeList()
                                                  .map((size) {
                                                List<VariantSizeQuantity>
                                                    availableSizeForSelectedColor =
                                                    state.selectedVariant
                                                        .firstWhere((value) =>
                                                            value.color ==
                                                            color.color)
                                                        .availableSizeWithQuantity;
                                                bool isSelected =
                                                    availableSizeForSelectedColor
                                                        .any((element) =>
                                                            element.size ==
                                                            size);
                                                return Column(
                                                  children: [
                                                    CheckboxListTile(
                                                        title: Text(size),
                                                        value: isSelected,
                                                        onChanged: (_) {
                                                          context
                                                              .read<
                                                                  AddProductCubit>()
                                                              .onSelectSize(
                                                                  color.color!,
                                                                  size);
                                                        }),
                                                    if (isSelected)
                                                      QuantityFieldWithIncrementer(
                                                        onDecrementButtonPressed:
                                                            (quantity) => context
                                                                .read<
                                                                    AddProductCubit>()
                                                                .onChangeQuantity(
                                                                    color
                                                                        .color!,
                                                                    size,
                                                                    quantity),
                                                        onIncrementButtonPressed:
                                                            (quantity) => context
                                                                .read<
                                                                    AddProductCubit>()
                                                                .onChangeQuantity(
                                                                    color
                                                                        .color!,
                                                                    size,
                                                                    quantity),
                                                        onQuantityChanged:
                                                            (quantity) => context
                                                                .read<
                                                                    AddProductCubit>()
                                                                .onChangeQuantity(
                                                                    color
                                                                        .color!,
                                                                    size,
                                                                    quantity),
                                                        quantity:
                                                            availableSizeForSelectedColor
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .size ==
                                                                        size)
                                                                .quantity,
                                                      )
                                                  ],
                                                );
                                              }).toList() ??
                                              [],
                                        )
                                      ],
                                    ))
                                .toList(),
                          );
                        }
                      },
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.selectedCategory == null
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please select category first'),
                                    ),
                                  );
                                }
                              : () async {
                                  final result = await showDialog<Color?>(
                                    context: context,
                                    builder: (c) {
                                      Color? color;
                                      return AlertDialog(
                                        title: const Text('Pick a color!'),
                                        content: BlockPicker(
                                          pickerColor: null,
                                          onColorChanged: (val) {
                                            color = val;
                                          },
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              c.maybePop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              c.maybePop(color);
                                            },
                                            child: const Text('OK'),
                                          )
                                        ],
                                      );
                                    },
                                  );

                                  if (result != null && context.mounted) {
                                    context
                                        .read<AddProductCubit>()
                                        .onAddColor(result.value);
                                  }
                                },
                          child: Text(state.selectedVariant.isEmpty
                              ? 'Pick Color'
                              : 'Pick another color'),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AddProductCubit>().onAddProduct();
                          }
                        },
                        child: state.addProductLoadingState.maybeWhen(
                          orElse: () => const Text('Add product'),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
