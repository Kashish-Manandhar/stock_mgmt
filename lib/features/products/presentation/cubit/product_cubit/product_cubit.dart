import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/data/product_data_source.dart';
import 'package:stock_management/features/products/data/product_response_model.dart';
import 'package:stock_management/features/products/presentation/cubit/product_cubit/product_state.dart';

import '../../../data/product_model.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(
    this._productDataSource,
  ) : super(const ProductState());

  final ProductDataSource _productDataSource;

  @postConstruct
  void fetchAllProducts() async {
    emit(
      state.copyWith(isLoading: true),
    );

    try {
      final productResponseModel = await _productDataSource.getProducts();

      emit(
        state.copyWith(
            productResponseModel: productResponseModel, isLoading: false),
      );
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), isLoading: false),
      );
    }
  }

  void addProductToList(Product product) {
    List<Product> productList = state.productResponseModel.productList.toList();

    emit(state.copyWith(
        productResponseModel: ProductResponseModel(
      productList: productList..insert(0, product),
      snapshot: state.productResponseModel.snapshot,
      hasMoreData: state.productResponseModel.hasMoreData,
    )));
  }

  void fetchMoreProducts() async {
    emit(
      state.copyWith(isMoreLoading: true),
    );

    try {
      final productResponseModel = await _productDataSource
          .getMoreProducts(state.productResponseModel.snapshot!);

      emit(
        state.copyWith(
            productResponseModel: ProductResponseModel(
              hasMoreData: productResponseModel.hasMoreData,
              snapshot: productResponseModel.snapshot,
              productList: state.productResponseModel.productList
                ..addAll(productResponseModel.productList),
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
