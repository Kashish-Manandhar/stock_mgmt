import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_state.dart';

import '../../../../categories/domain/categories_model.dart';
import '../../../../products/data/product_model.dart';

@injectable
class AddSalesFormCubit extends Cubit<AddSalesFormState> {
  AddSalesFormCubit()
      : super(
          const AddSalesFormState(),
        );

  void onChangeCategory(CategoriesModel categoriesModel) {
    emit(
      state.copyWith(
        salesModel: state.salesModel.copyWith(category: categoriesModel),
      ),
    );
  }

  void onChangeProduct(Product product) {
    emit(
      state.copyWith(
        salesModel: state.salesModel.copyWith(
            product: product,
            category: state.salesModel.category ??
                CategoriesModel.fromJson(product.category)),
      ),
    );
  }

  void onChangeQuantity(String quantity) {
    emit(
      state.copyWith(
        salesModel:
            state.salesModel.copyWith(quantity: int.tryParse(quantity) ?? 0),
      ),
    );
  }

  void onChangePrice(String price) {
    emit(
      state.copyWith(
        salesModel:
        state.salesModel.copyWith(price: double.tryParse(price) ?? 0),
      ),
    );
  }
}
