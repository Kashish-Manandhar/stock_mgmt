import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/products/data/product_model.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_cubit/add_sales_state.dart';

@injectable
class AddSalesCubit extends Cubit<AddSalesState> {
  AddSalesCubit() : super(const AddSalesState());

  void addSalesItem(SalesDataModel salesDataModel) {
    List<SalesDataModel> salesList = state.salesList.toList();

    emit(
      state.copyWith(
        salesList: salesList..add(salesDataModel),
      ),
    );
  }


}
