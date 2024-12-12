import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/extensions/enum_extension.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/add_category_cubit/add_category_cubit.dart';
import '../cubit/add_category_cubit/add_category_state.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({super.key, this.categoriesModel});

  final CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocListener<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        state.loadingState.mapOrNull(success: (_) {
          context.maybePop();
        });
      },
      listenWhen: (p, n) => p.loadingState != n.loadingState,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              CustomTextFormField(
                labelText: 'Category Name',
                initialValue: categoriesModel?.categoryName,
                validators: (val) {
                  if (val != null && val.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged:
                    context.read<AddCategoryCubit>().onChangeCategoryName,
              ),
              const SizedBox(
                height: 10,
              ),
              ...AvailableSize.values.map(
                  (size) => BlocBuilder<AddCategoryCubit, AddCategoryState>(
                        builder: (context, state) => Row(
                          children: [
                            Radio<AvailableSize?>(
                                value: size,
                                groupValue: state.availableSize,
                                onChanged: (val) => context
                                    .read<AddCategoryCubit>()
                                    .onChangeAvailableSize(val)),
                            Text(size.getStringValue()),
                          ],
                        ),
                      )),
              BlocBuilder<AddCategoryCubit, AddCategoryState>(
                  builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<AddCategoryCubit>().onAddCategory();
                    }
                  },
                  child: state.loadingState ==
                          const AddCategoryLoadingState.loading()
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Add Category'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
