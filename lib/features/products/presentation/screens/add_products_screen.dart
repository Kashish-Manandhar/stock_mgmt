import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/constants/constants.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/widgets/custom_dropdown_field.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
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
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                      bloc: getIt<CategoriesCubit>(),
                      builder: (context, categoryState) {
                        return BlocBuilder<AddProductCubit, AddProductState>(
                            builder: (context, state) {
                          return CustomDropdownField<CategoriesModel>(
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
                      builder: (context, state) {
                    return Column(
                      children: availableSizes.map((availableSize) {
                        final isSelected = state
                            .product.availableSizeWithQuantity
                            .containsKey(availableSize);
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(availableSize)),
                                InkWell(
                                  child: Icon(isSelected
                                      ? Icons.arrow_drop_down_outlined
                                      : Icons.arrow_drop_up_outlined),
                                  onTap: () => context
                                      .read<AddProductCubit>()
                                      .onSelectSize(availableSize),
                                )
                              ],
                            ),
                            if (isSelected) ...[
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                initialValue: state.product
                                    .availableSizeWithQuantity[availableSize]
                                    ?.toString(),
                                labelText: 'Quantity',
                                validators: (val) {
                                  if (val != null && val.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                                onChanged: (quantity) => context
                                    .read<AddProductCubit>()
                                    .onChangeQuantity(availableSize, quantity),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]
                          ],
                        );
                      }).toList(),
                    );
                  }),
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
