import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/sales_data_model.dart';

part 'add_sales_state.freezed.dart';

@freezed
class AddSalesState with _$AddSalesState {
  const factory AddSalesState({
    @Default([]) List<SalesDataModel> salesList,
  }) = _AddSalesState;
}
