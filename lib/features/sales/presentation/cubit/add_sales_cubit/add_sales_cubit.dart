import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/sales/data/sales_data_source.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_state.dart';

import '../../../../products/data/product_model.dart';

@injectable
class AddSalesCubit extends Cubit<AddSalesState> {
  AddSalesCubit(this._salesDataSource) : super(const AddSalesState());
  final SalesDataSource _salesDataSource;

  void addSalesItem((SalesProductModel, Product) saleItemWithProduct) {
    List<SalesProductModel> salesList =
        state.saleDataModel.saleItemList.toList();

    emit(
      state.copyWith.saleDataModel(
        saleItemList: salesList..add(saleItemWithProduct.$1),
        selectedProductList: state.saleDataModel.selectedProductList.toList()
          ..add(saleItemWithProduct.$2),
      ),
    );
  }

  void updateSalesItem((SalesProductModel, Product) saleItemWithProduct) {
    final updatedSaleItem = saleItemWithProduct.$1;
    final updateProduct = saleItemWithProduct.$2;

    emit(
      state.copyWith.saleDataModel(
        saleItemList: state.saleDataModel.saleItemList.map((saleItem) {
          if (saleItem.productCode == updatedSaleItem.productCode) {
            return updatedSaleItem;
          }
          return saleItem;
        }).toList(),
        selectedProductList:
            state.saleDataModel.selectedProductList.map((product) {
          if (updateProduct.productCode == product.productCode) {
            return updateProduct;
          }
          return product;
        }).toList(),
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
        for (final size in variant.availableSizeWithQuantity) {
          quantity += size.quantity;
        }
      }
      price += salesItem.price * quantity;
    }

    final newSalesData = state.saleDataModel.copyWith(
      totalPrice: price,
      createdTime: DateTime.now(),
    );

    try {
      await _salesDataSource.addSalesToFireStore(newSalesData);
      emit(
        state.copyWith(
          loadingState: AddSaleLoadingState.success(newSalesData),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: AddSaleLoadingState.error(Exception(e.toString)),
        ),
      );
    }
  }
}
