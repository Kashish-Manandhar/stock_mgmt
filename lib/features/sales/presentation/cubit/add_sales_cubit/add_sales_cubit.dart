import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/sales/data/sales_data_source.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_state.dart';

@injectable
class AddSalesCubit extends Cubit<AddSalesState> {
  AddSalesCubit(this._salesDataSource) : super(const AddSalesState());
  final SalesDataSource _salesDataSource;

  void addSalesItem(SalesProductModel salesProductModel) {
    List<SalesProductModel> salesList =
        state.saleDataModel.saleItemList.toList();

    emit(
      state.copyWith.saleDataModel(
        saleItemList: salesList..add(salesProductModel),
      ),
    );
  }

  void onChangeNotes(String? notes) {
    emit(
      state.copyWith.saleDataModel(note: notes),
    );
  }

  void onAddButtonPressed() async {
    emit(
      state.copyWith(
        loadingState: const AddSaleLoadingState.loading(),
      ),
    );

    double price = 0;
    for (final salesItem in state.saleDataModel.saleItemList) {
      int quantity = 0;
      for (final variant in salesItem.selectedVariantList) {
        quantity += variant.quantity ?? 0;
      }
      price += salesItem.price ?? 0 * quantity;
    }

    try {
      await _salesDataSource.addSalesToFireStore(
        state.saleDataModel.copyWith(
          totalPrice: price,
        ),
      );
      emit(
        state.copyWith(
          loadingState:  AddSaleLoadingState.success(state.saleDataModel),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState:  AddSaleLoadingState.error(Exception(e.toString)),
        ),
      );
    }
  }
}
