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
import '../cubit/add_sales_cubit/add_sales_cubit.dart';

class AddSalesBottomSheet extends StatelessWidget {
  const AddSalesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSalesFormCubit, AddSalesFormState>(
      builder: (context, state) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
                bloc: getIt<CategoriesCubit>(),
                builder: (context, categoryState) {
                  return CustomDropdownField<CategoriesModel>(
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
            ProductTypeAhead(
              salesDataModel: state.salesModel,
              onProductSelected: (val) =>
                  context.read<AddSalesFormCubit>().onChangeProduct(val),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              labelText: 'Quantity',
              onChanged: (val) =>
                  context.read<AddSalesFormCubit>().onChangeQuantity(val!),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              labelText: 'Selling Price',
              onChanged: (val) =>
                  context.read<AddSalesFormCubit>().onChangePrice(val!),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.maybePop(state.salesModel);
              },
              child: Text('Add Product for sales'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
