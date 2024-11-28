import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/constants/constants.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/widgets/custom_dropdown_field.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/products/presentation/cubit/add_product_cubit.dart';
import 'package:stock_management/features/products/presentation/cubit/add_product_state.dart';
import 'package:stock_management/features/products/presentation/cubit/variant_cubit/variant_cubit.dart';
import 'package:stock_management/features/products/presentation/cubit/variant_cubit/variant_state.dart';
import 'package:stock_management/features/products/presentation/widgets/image_holder.dart';
import 'package:stock_management/features/products/presentation/widgets/variant_input_widget.dart';

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
    return BlocProvider<AddProductCubit>(
      create: (_) => getIt<AddProductCubit>(param1: widget.product),
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
                      onChanged:
                          context.read<AddProductCubit>().onChangeProductPrice,
                      validators: (val) {
                        if (val != null && val.isEmpty) return 'Required';
                        return null;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                      bloc: getIt<CategoriesCubit>(),
                      builder: (context, categoryState) {
                        return BlocBuilder<AddProductCubit, AddProductState>(
                            builder: (context, state) {
                          return CustomDropdownField<CategoriesModel>(
                            labelText: 'Categories',
                            initialValue: state.product.category.isEmpty
                                ? null
                                : CategoriesModel.fromJson(
                                    state.product.category),
                            onChanged: context
                                .read<AddProductCubit>()
                                .onChangeCategory,
                            items: categoryState.isFromFirebase
                                ? []
                                : categoryState.categoryList.isEmpty
                                    ? []
                                    : categoryState.categoryList
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
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AddProductCubit, AddProductState>(
                      builder: (context, productState) {
                    return Row(
                      children: [
                        Text('Variants:'),
                        TextButton(
                            onPressed: () async {
                              final result = await showDialog<VariantModel>(
                                  context: context,
                                  builder: (c) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        content: BlocProvider(
                                          create: (_) => getIt<VariantCubit>(),
                                          child: BlocBuilder<VariantCubit,
                                              VariantState>(
                                            builder: (c, state) {
                                              return InputVariantWidget(
                                                availableSize: productState
                                                        .product
                                                        .category
                                                        .isEmpty
                                                    ? CategoriesModel.fromJson(
                                                            productState.product
                                                                .category)
                                                        .availableSize
                                                    : AvailableSize.alphaSize,
                                                onChangeColor: c
                                                    .read<VariantCubit>()
                                                    .onChangeColor,
                                                onChangeQuantity: c
                                                    .read<VariantCubit>()
                                                    .onChangeQuantity,
                                                onSelectSize: c
                                                    .read<VariantCubit>()
                                                    .onSelectSize,
                                                variantModel:
                                                    state.variantModel,
                                                onAddPressed: () {
                                                  c.maybePop(
                                                      state.variantModel);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ));
                              if (result != null && context.mounted) {
                                context
                                    .read<AddProductCubit>()
                                    .onAddVariant(result);
                              }
                            },
                            child: Text('Add new variant')),
                      ],
                    );
                  }),
                  BlocBuilder<AddProductCubit, AddProductState>(
                      builder: (_, state) {
                    if (state.product.variantList.isEmpty) {
                      return Text('No Variant added. Please add one');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.product.variantList.length,
                        itemBuilder: (_, i) {
                          final variantModel = state.product.variantList[i];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Color:'),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Color(variantModel.color!)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Size:'),
                                  Text(variantModel.size?.toString() ?? ''),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Quantity:'),
                                  Text(
                                      variantModel.quantity?.toString() ?? '1'),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
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
  }
}
