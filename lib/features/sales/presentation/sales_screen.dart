import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/auto_route/app_router.gr.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/sales_cubit/sales_cubit.dart';
import 'package:stock_management/features/sales/presentation/cubit/sales_cubit/sales_state.dart';
import 'package:stock_management/features/sales/presentation/widgets/sales_list.dart';

@RoutePage()
class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sales List'),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<SalesCubit, SalesState>(
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

                    if (state.salesResponseModel.salesList.isNotEmpty) {
                      return SalesList(
                        salesResponseModel: state.salesResponseModel,
                        isMoreLoading: state.isMoreLoading,
                      );
                    } else {
                      return const Text('No products');
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
                SalesDataModel? result = await context.router.push(
                  const AddSalesRoute(),
                );
                //
                if (result != null) {
                  if (!context.mounted) return;
                  context.read<SalesCubit>().addProductToList(result);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
