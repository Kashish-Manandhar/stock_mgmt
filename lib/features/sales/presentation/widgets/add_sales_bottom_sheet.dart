import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_cubit.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_state.dart';
import 'package:stock_management/features/sales/presentation/widgets/product_type_ahead.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../categories/domain/categories_model.dart';
import '../../../categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import '../../../categories/presentation/cubit/categories_cubit/categories_state.dart';

class AddSalesBottomSheet extends StatefulWidget {
  const AddSalesBottomSheet({super.key});

  @override
  State<AddSalesBottomSheet> createState() => _AddSalesBottomSheetState();
}

class _AddSalesBottomSheetState extends State<AddSalesBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
      builder: (context, state) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                  bloc: getIt<CategoriesCubit>(),
                  builder: (context, categoryState) {
                    return CustomDropdownField<CategoriesModel>(
                        labelText: 'Category',
                        initialValue: state.salesModel.category,
                        onChanged: (val) => context
                            .read<AddSalesFormCubit>()
                            .onChangeCategory(val!),
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
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              const Text('Product Code'),
              const SizedBox(
                height: 8,
              ),
              ProductTypeAhead(
                salesDataModel: state.salesModel,
                onProductSelected: (val) =>
                    context.read<AddSalesFormCubit>().onChangeProduct(val),
              ),
              const SizedBox(
                height: 20,
              ),
              // ...state.salesModel.product?.availableSizeWithQuantity.keys
              //         .map(
              //           (key) => Row(
              //             children: [
              //               Text(key),
              //                Expanded(child: SizedBox(),),
              //
              //               IconButton(onPressed: (){}, icon: Icon(Icons.remove)),
              //
              //               CustomTextFormField(),
              //
              //               IconButton(onPressed: (){}, icon: Icon(Icons.add))
              //             ],
              //           ),
              //         )
              //         .toList() ??
              //     [SizedBox()],

              // CustomTextFormField(
              //   labelText: 'Quantity',
              //   onChanged: (val) =>
              //       context.read<AddSalesFormCubit>().onChangeQuantity(val!),
              //   validators: (val) {
              //     if (val != null && val.isEmpty) {
              //       return 'Required';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                labelText: 'Selling Price',
                onChanged: (val) =>
                    context.read<AddSalesFormCubit>().onChangePrice(val!),
                validators: (val) {
                  final productPrice = state.salesModel.product?.price ?? 0;
                  if (val != null && val.isEmpty) {
                    return 'Required';
                  } else {
                    double price = double.tryParse(val ?? '') ?? 0;
                    if (price < productPrice) {
                      return 'Price must be greater than or equal to the cost price';
                    } else {
                      return null;
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.maybePop(state.salesModel);
                  }
                },
                child: const Text('Add Product for sales'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
