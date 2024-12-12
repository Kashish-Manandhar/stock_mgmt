import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_state.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
import 'package:stock_management/features/categories/presentation/widgets/add_category_bottom_sheet.dart';

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
            if(!success.isEdit){

            context
                .read<CategoriesCubit>()
                .addCategoryModel(success.categoryModel);
            }
            else{
              context
                  .read<CategoriesCubit>()
                  .updateCategoryModel(success.categoryModel);
            }
          });
        },
        listenWhen: (p, n) => p.loadingState != n.loadingState,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories List'),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (_, state) {
                    if (state.categoryList.isNotEmpty) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                context: context,
                                builder: (c) {
                                  return BlocProvider.value(
                                    value: context.read<AddCategoryCubit>()
                                      ..initCategory(state.categoryList[index]),
                                    child: AddCategoryBottomSheet(
                                      categoriesModel:
                                          state.categoryList[index],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(state
                                        .categoryList[index].categoryName)),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                        itemCount: state.categoryList.length,
                      );
                    } else {
                      return const Text('No categories Added!');
                    }
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    context: context,
                    builder: (c) {
                      return BlocProvider.value(
                        value: context.read<AddCategoryCubit>(),
                        child: const AddCategoryBottomSheet(),
                      );
                    });
              },
              child: const Icon(Icons.add),
            );
          }),
        ),
      ),
    );
  }
}
