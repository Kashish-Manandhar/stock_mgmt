import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';

part 'add_sales_state.freezed.dart';

@freezed
class AddSalesState with _$AddSalesState {
  const factory AddSalesState({
    @Default(SalesDataModel()) SalesDataModel saleDataModel,
    @Default(AddSaleLoadingState.initial()) AddSaleLoadingState loadingState,
  }) = _AddSalesState;
}

@freezed
class AddSaleLoadingState with _$AddSaleLoadingState {
  const factory AddSaleLoadingState.initial() = _AddSaleInitialState;

  const factory AddSaleLoadingState.loading() = _AddSaleLoadingState;

  const factory AddSaleLoadingState.success(SalesDataModel salesDataModel) =
      _AddSaleSuccessState;

  const factory AddSaleLoadingState.error(Exception error) = _AddSaleErrorState;
}
