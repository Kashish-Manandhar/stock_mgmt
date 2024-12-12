import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/data/product_data_source.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/add_sales_form_cubit/add_sales_form_state.dart';

import '../../../../categories/domain/categories_model.dart';
import '../../../../products/data/product_model.dart';

@injectable
class AddSalesFormCubit extends Cubit<AddSalesFormState> {
  AddSalesFormCubit(
    this._productDataSource, {
    @factoryParam this.categoriesList = const [],
    @factoryParam this.salesProductModel,
  }) : super(
          const AddSalesFormState(),
        );

  List<CategoriesModel> categoriesList;
  SalesProductModel? salesProductModel;
  final ProductDataSource _productDataSource;

  @postConstruct
  void initializeCubit() async {
    if (salesProductModel != null) {
      emit(state.copyWith(fetchProduct: true));
      final category = categoriesList.firstWhere(
          (category) => category.categoryId == salesProductModel!.categoryId);
      final productList = await _productDataSource.searchProduct(
          search: salesProductModel!.productCode,
          categoryId: category.categoryId);

      emit(
        state.copyWith(
          fetchProduct: false,
          selectedCategory: category,
          selectedProduct: productList.isEmpty ? null : productList.first,
          selectedVariantList: salesProductModel!.selectedVariantList,
          price: salesProductModel!.price,
        ),
      );
    }
  }

  void onChangeCategory(CategoriesModel categoriesModel) {
    emit(
      state.copyWith(
          selectedCategory: categoriesModel,
          selectedProduct: null,
          selectedVariantList: []),
    );
  }

  void onChangeProduct(Product product) {
    emit(
      state.copyWith(
          selectedProduct: product,
          selectedCategory: state.selectedCategory ??
              categoriesList.firstWhere(
                  (value) => value.categoryId == product.categoryId),
          selectedVariantList: product.variantList
              .map((e) => VariantColorSizeModel(color: e.color))
              .toList()),
    );
  }

  void onChangePrice(String price) {
    emit(
      state.copyWith(
        price: double.tryParse(price),
      ),
    );
  }

  void onSelectSize(int selectedColor, String selectedSize) {
    final variantSelected = state.selectedProduct?.variantList
        .firstWhere((element) => element.color == selectedColor)
        .availableSizeWithQuantity
        .firstWhere((element) => element.size == selectedSize);
    if (variantSelected == null) {
      return;
    }
    List<VariantColorSizeModel> selectedVariantList =
        state.selectedVariantList.map((variant) {
      if (variant.color == selectedColor) {
        if (variant.availableSizeWithQuantity
            .any((sizes) => sizes.size == selectedSize)) {
          return variant.copyWith(
              availableSizeWithQuantity: variant.availableSizeWithQuantity
                  .where((size) => size.size != selectedSize)
                  .toList());
        } else {
          return variant.copyWith(availableSizeWithQuantity: [
            ...variant.availableSizeWithQuantity,
            variantSelected
          ]);
        }
      }
      return variant;
    }).toList();
    emit(state.copyWith(selectedVariantList: selectedVariantList));
  }

  void onChangeQuantity(int selectedColor, String selectedSize, int quantity) {
    List<VariantColorSizeModel> variantList =
        state.selectedVariantList.map((variant) {
      if (variant.color == selectedColor) {
        List<VariantSizeQuantity> sizeList = variant.availableSizeWithQuantity;
        return variant.copyWith(
          availableSizeWithQuantity: sizeList.map((size) {
            if (size.size == selectedSize) {
              return size.copyWith(quantity: quantity);
            }
            return size;
          }).toList(),
        );
      }
      return variant;
    }).toList();

    emit(state.copyWith(selectedVariantList: variantList));
  }

  void onAddSalesProduct() {
    SalesProductModel salesProductModel = SalesProductModel(
        price: state.price!,
        categoryId: state.selectedCategory?.categoryId ?? '',
        productCode: state.selectedProduct?.productCode ?? '',
        selectedVariantList: state.selectedVariantList
            .where((element) => element.availableSizeWithQuantity.isNotEmpty)
            .toList());

    emit(
      state.copyWith(
        successState: AddSalesFormSuccessState.success(
            salesProductModel, state.selectedProduct!),
      ),
    );
  }
}
