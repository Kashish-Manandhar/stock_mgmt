import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';

part 'reports_state.freezed.dart';

@freezed
class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(SalesResponseModel()) SalesResponseModel salesResponseModel,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isLoading,
    @Default(0) int selectedTab,
    required DateTime firstDay,
    required DateTime lastDay,
  }) = _ReportsState;
}
