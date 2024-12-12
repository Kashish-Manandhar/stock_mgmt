import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/features/reports/presentation/cubit/reports_cubit/reports_cubit.dart';
import 'package:stock_management/features/reports/presentation/cubit/reports_cubit/reports_state.dart';
import 'package:stock_management/features/reports/presentation/widgets/tab_widget.dart';
import 'package:stock_management/features/sales/presentation/widgets/sales_list.dart';

@RoutePage()
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReportsCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              BlocBuilder<ReportsCubit, ReportsState>(
                  builder: (context, state) {
                return TabWidget(
                  selectedIndex: state.selectedTab,
                  onSelectIndex: context.read<ReportsCubit>().onSelectTab,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<ReportsCubit, ReportsState>(
                    builder: (context, state) {
                  return state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SalesList(salesResponseModel: state.salesResponseModel);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
