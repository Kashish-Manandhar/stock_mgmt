import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_cubit.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_state.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_cubit.dart';
import 'package:stock_management/features/sales/presentation/widgets/add_sales_bottom_sheet.dart';

@RoutePage()
class AddSalesScreen extends StatefulWidget {
  const AddSalesScreen({super.key});

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSalesCubit>(
      create: (_) => getIt<AddSalesCubit>(),
      child: BlocListener<AddSalesCubit, AddSalesState>(
        listener: (context, state) {
          state.loadingState.mapOrNull(success: (success) {
            context.router.maybePop(success.salesDataModel);
          }, error: (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.error.toString())));
          });
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    BlocBuilder<AddSalesCubit, AddSalesState>(
                        builder: (_, state) {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: state.saleDataModel.saleItemList.isEmpty
                            ? const Text('No products added in sale!')
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (c, i) {
                                  final salesModel =
                                      state.saleDataModel.saleItemList[i];

                                  return ListTile(
                                    title: Text(
                                        salesModel.product?.productCode ?? ''),
                                    subtitle: Wrap(
                                        children: salesModel.selectedVariantList
                                            .map((e) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(e.size ?? ''),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(e.color!),
                                                          shape:
                                                              BoxShape.circle),
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                    Text(e.quantity
                                                            ?.toString() ??
                                                        '')
                                                  ],
                                                ))
                                            .toList()),
                                  );
                                },
                                itemCount:
                                    state.saleDataModel.saleItemList.length,
                              ),
                      );
                    }),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () async {
                          final result =
                              await showModalBottomSheet<SalesProductModel?>(
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
                    Builder(builder: (context) {
                      return CustomTextFormField(
                        labelText: 'Note',
                        maxLines: 5,
                        onChanged: context.read<AddSalesCubit>().onChangeNotes,
                        validators: (val) {
                          if (val != null && val.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      );
                    }),
                    BlocBuilder<AddSalesCubit, AddSalesState>(
                        builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (state.saleDataModel.saleItemList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please add sales item.'),
                                ),
                              );
                            } else {
                              context
                                  .read<AddSalesCubit>()
                                  .onAddButtonPressed();
                            }
                          }
                        },
                        child: state.loadingState.maybeWhen(
                          orElse: () => Text('Add Sales'),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
