import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/add_category_cubit/add_category_state.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:stock_management/features/categories/presentation/cubit/categories_cubit/categories_state.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AddCategoryCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<CategoriesCubit>(),
        ),
      ],
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
                Text('Categories List'),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (_, state) {
                    if (state.categoryList.isNotEmpty) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) =>
                            Text(state.categoryList[index].categoryName),
                        itemCount: state.categoryList.length,
                      );
                    } else {
                      return Text('No categories Added!');
                    }
                  },
                ),
                Builder(builder: (context) {
                  return FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (c) => BlocProvider.value(
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .lightBlueAccent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .lightBlueAccent)),
                                              labelText: 'Category Name'),
                                          onChanged: context
                                              .read<AddCategoryCubit>()
                                              .onChangeCategoryName,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BlocBuilder<AddCategoryCubit,
                                                AddCategoryState>(
                                            builder: (context, state) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<AddCategoryCubit>()
                                                  .onAddCategory();
                                            },
                                            child: state.loadingState ==
                                                    AddCategoryLoadingState
                                                        .loading()
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Text('Add Category'),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: Icon(Icons.add),
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
