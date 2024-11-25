import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/sales_data_model.dart';

part 'add_sales_form_state.freezed.dart';

@freezed
class AddSalesFormState with _$AddSalesFormState {
  const factory AddSalesFormState({
    @Default(SalesDataModel()) SalesDataModel salesModel,
  }) = _AddSalesFormState;
}
