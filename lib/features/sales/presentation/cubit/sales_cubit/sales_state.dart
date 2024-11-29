import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';

part 'sales_state.freezed.dart';

@freezed
class SalesState with _$SalesState {
  const factory SalesState({
    @Default(SalesResponseModel()) SalesResponseModel salesResponseModel,
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    String? errorMessage,
  }) = _SalesState;
}
