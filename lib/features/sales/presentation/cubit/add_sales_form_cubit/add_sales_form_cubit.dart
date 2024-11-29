import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
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
        salesModel: state.salesModel.copyWith(categoriesModel: categoriesModel),
      ),
    );
  }

  void onChangeProduct(Product product) {
    emit(
      state.copyWith(
        salesModel: state.salesModel.copyWith(
            product: product,
            categoriesModel: state.salesModel.categoriesModel ??
                CategoriesModel.fromJson(product.category)),
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

  void onSelectVariant(VariantModel model) {
    List<VariantModel> variantList = state.salesModel.selectedVariantList.toList();

    if (variantList.contains(model)) {
      variantList.remove(model);
    } else {
      variantList.add(model);
    }

    emit(state.copyWith.salesModel(selectedVariantList: variantList));
  }

  void onChangeQuantity(int quantity, VariantModel variantModel) {
    List<VariantModel> variantList = state.salesModel.selectedVariantList.toList();

    int i = variantList.indexWhere((val) =>
        val.size == variantModel.size && val.color == variantModel.color);

    variantList[i] = variantModel.copyWith(quantity: quantity);

    emit(state.copyWith.salesModel(selectedVariantList: variantList));
  }
}
