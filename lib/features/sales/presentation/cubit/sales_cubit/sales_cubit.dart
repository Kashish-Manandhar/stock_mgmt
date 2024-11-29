import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/data/sales_data_source.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/sales_cubit/sales_state.dart';
@injectable
class SalesCubit extends Cubit<SalesState>{
  SalesCubit(this._salesDataSource):super(SalesState());
  final SalesDataSource _salesDataSource;

  @postConstruct
  void fetchAllProducts() async {
    emit(
      state.copyWith(isLoading: true),
    );

    try {
      final salesResponseModel = await _salesDataSource.getProducts();

      emit(
        state.copyWith(
            salesResponseModel: salesResponseModel, isLoading: false),
      );
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), isLoading: false),
      );
    }
  }

  void addProductToList(SalesDataModel salesData) {
    List<SalesDataModel> salesList = state.salesResponseModel.salesList.toList();

    emit(state.copyWith(
        salesResponseModel: SalesResponseModel(
          salesList: salesList..insert(0,salesData),
          snapshot: state.salesResponseModel.snapshot,
          hasMoreData: state.salesResponseModel.hasMoreData,
        )));
  }

  void fetchMoreProducts() async {
    emit(
      state.copyWith(isMoreLoading: true),
    );

    try {
      final salesResponseModel = await _salesDataSource
          .getMoreProducts(state.salesResponseModel.snapshot!);

      emit(
        state.copyWith(
            salesResponseModel: SalesResponseModel(
              hasMoreData: salesResponseModel.hasMoreData,
              snapshot: salesResponseModel.snapshot,
              salesList: state.salesResponseModel.salesList
                ..addAll(salesResponseModel.salesList),
            ),
            isMoreLoading: false),
      );
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), isMoreLoading: false),
      );
    }
  }
}