import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/extensions/date_extension.dart';
import 'package:stock_management/features/reports/presentation/cubit/reports_cubit/reports_state.dart';
import 'package:stock_management/features/sales/data/sales_data_source.dart';

@injectable
class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this._salesDataSource)
      : super(ReportsState(
          firstDay: DateTime.now().todayStartTime,
          lastDay: DateTime.now().nextDayStartTime,
        ));
  final SalesDataSource _salesDataSource;

  @postConstruct
  void fetchSales() async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _salesDataSource.getProducts(
        startTime: state.firstDay,
        endTime: state.lastDay,
      );

      emit(state.copyWith(salesResponseModel: result, isLoading: false));
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      emit(state);
    }
  }

  void onSelectTab(int selectedTab) {
    late List<DateTime> selectedDays;
    final previousSelectedTab = state.selectedTab;
    final todayDate = DateTime.now();
    if (selectedTab == 0) {
      selectedDays = [todayDate.todayStartTime, todayDate.nextDayStartTime];
    } else if (selectedTab == 1) {
      selectedDays = todayDate.todayStartTime.getFirstAndLastDayOfWeek;
    } else if (selectedTab == 2) {
      selectedDays = todayDate.todayStartTime.getFirstAndLastDayOfMonth;
    }

    if (previousSelectedTab != selectedTab) {
      emit(
        state.copyWith(
            selectedTab: selectedTab,
            firstDay: selectedDays.first,
            lastDay: selectedDays.last),
      );

      fetchSales();
    }
  }
}
