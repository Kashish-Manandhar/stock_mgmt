import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/constants/constants.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/extensions/enum_extension.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_state.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddCategoryCubit>(),
      child: BlocListener<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          state.loadingState.mapOrNull(success: (success) {
            context
                .read<CategoriesCubit>()
                .addCategoryModel(success.categoryModel);
          });
        },
        listenWhen: (p, n) => p.loadingState != n.loadingState,
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Categories List'),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (_, state) {
                    if (state.categoryList.isNotEmpty) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) =>
                            Text(state.categoryList[index].categoryName),
                        itemCount: state.categoryList.length,
                      );
                    } else {
                      return const Text('No categories Added!');
                    }
                  },
                ),
                Builder(builder: (context) {
                  return FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (c) {
                            final formKey = GlobalKey<FormState>();
                            return BlocProvider.value(
                              value: context.read<AddCategoryCubit>(),
                              child: BlocListener<AddCategoryCubit,
                                  AddCategoryState>(
                                listener: (context, state) {
                                  state.loadingState.mapOrNull(success: (_) {
                                    c.maybePop();
                                  });
                                },
                                listenWhen: (p, n) =>
                                    p.loadingState != n.loadingState,
                                child: Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          labelText: 'Category Name',
                                          validators: (val) {
                                            if (val != null && val.isEmpty) {
                                              return 'Required';
                                            }
                                            return null;
                                          },
                                          onChanged: context
                                              .read<AddCategoryCubit>()
                                              .onChangeCategoryName,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ...AvailableSize.values
                                            .map((size) => BlocBuilder<AddCategoryCubit,AddCategoryState>(
                                              builder:(context,state)=> Row(
                                                    children: [
                                                      Radio<AvailableSize?>(
                                                          value: size,
                                                          groupValue: state.availableSize,
                                                          onChanged: (val) => context.read<AddCategoryCubit>().onChangeAvailableSize(val)),
                                                      Text(size.getStringValue()),
                                                    ],
                                                  ),
                                            )),
                                        BlocBuilder<AddCategoryCubit,
                                                AddCategoryState>(
                                            builder: (context, state) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              if (formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                context
                                                    .read<AddCategoryCubit>()
                                                    .onAddCategory();
                                              }
                                            },
                                            child: state.loadingState ==
                                                    const AddCategoryLoadingState
                                                        .loading()
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : const Text('Add Category'),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: const Icon(Icons.add),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
