import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/products/presentation/cubit/product_cubit/product_cubit.dart';

@RoutePage()
class ProductsWrapperScreen extends StatelessWidget {
  const ProductsWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: const AutoRouter(),
    );
  }
}
