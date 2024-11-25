import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/products/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:stock_management/features/products/presentation/cubit/product_cubit/product_state.dart';
import 'package:stock_management/features/products/presentation/screens/product_list.dart';

import '../../data/product_model.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Product List'),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.errorMessage != null) {
                      return Center(
                        child: Text(state.errorMessage ?? ''),
                      );
                    }

                    if (state.productResponseModel.productList.isNotEmpty) {
                      return ProductList(
                        productResponseModel: state.productResponseModel,
                        isMoreLoading: state.isMoreLoading,
                      );
                    } else {
                      return Text('No products');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                Product? result = await context.router.push(
                  AddProductsRoute(),
                );

                if (result != null) {
                  if (!context.mounted) return;
                  context.read<ProductCubit>().addProductToList(result);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
