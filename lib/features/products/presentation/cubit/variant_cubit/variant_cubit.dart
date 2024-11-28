import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/presentation/cubit/variant_cubit/variant_state.dart';

@injectable
class VariantCubit extends Cubit<VariantState> {
  VariantCubit() : super(const VariantState());

  void onChangeQuantity(int quantity) =>
      emit(state.copyWith.variantModel(quantity: quantity));

  void onChangeColor(int color) =>
      emit(state.copyWith.variantModel(color: color));

  void onSelectSize(String? size) =>
      emit(state.copyWith.variantModel(size: size));
}
