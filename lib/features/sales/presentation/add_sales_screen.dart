import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_cubit.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_state.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_cubit.dart';
import 'package:stock_management/features/sales/presentation/widgets/add_sales_bottom_sheet.dart';


@RoutePage()
class AddSalesScreen extends StatelessWidget {
  const AddSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSalesCubit>(
      create: (_) => getIt<AddSalesCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                BlocBuilder<AddSalesCubit, AddSalesState>(builder: (_, state) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: state.salesList.isEmpty
                        ? const Text('No products added in sale!')
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              final salesModel = state.salesList[i];

                              return ListTile(
                                title:
                                    Text(salesModel.product?.productCode ?? ''),
                                subtitle:
                                    Text(salesModel.quantity?.toString() ?? ''),
                              );
                            },
                            itemCount: state.salesList.length,
                          ),
                  );
                }),

                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      final result =
                          await showModalBottomSheet<SalesDataModel?>(
                        context: context,
                        enableDrag: true,
                        isDismissible: false,
                        builder: (_) => BlocProvider(
                          create: (_) => getIt<AddSalesFormCubit>(),
                          child: const AddSalesBottomSheet(),
                        ),
                      );

                      if (result != null && context.mounted) {
                        context.read<AddSalesCubit>().addSalesItem(result);
                      }
                    },
                    child: const Text('Add More Product'),
                  );
                }),

                const CustomTextFormField(
                  labelText: 'Note',
                  maxLines: 5,
                ),

                // Builder(builder: (context) {
                //   return ElevatedButton(
                //     onPressed: () =>
                //         context.read<AddSalesCubit>().addSalesItem(),
                //     child: const Text('Add Sales'),
                //   );
                // }),
              ],
            )),
      ),
    );
  }
}
