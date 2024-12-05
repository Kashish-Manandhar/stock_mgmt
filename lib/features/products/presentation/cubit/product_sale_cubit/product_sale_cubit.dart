import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/products/data/product_model.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/products/presentation/cubit/product_sale_cubit/product_sale_state.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/data/sales_data_source.dart';
import 'package:stock_management/features/sales/data/sales_product_model.dart';

@injectable
class ProductSaleCubit extends Cubit<ProductSaleState> {
  ProductSaleCubit(this._salesDataSource, {@factoryParam required this.product})
      : super(
          const ProductSaleState(),
        );

  final Product product;
  final SalesDataSource _salesDataSource;

  @postConstruct
  void initCubit() {
    emit(state.copyWith(
      variantList: product.variantList
          .map((e) => VariantColorSizeModel(
              color: e.color, availableSizeWithQuantity: []))
          .toList(),
    ));
  }

  void onSelectSize(int selectedColor, String selectedSize) {
    final selectedVariantFromProduct = product.variantList
        .firstWhere((variant) => variant.color == selectedColor)
        .availableSizeWithQuantity
        .firstWhere((size) => size.size == selectedSize);

    List<VariantColorSizeModel> variantList = state.variantList.map((variant) {
      if (variant.color == selectedColor) {
        List<VariantSizeQuantity> sizesList = variant.availableSizeWithQuantity;

        if (sizesList.any((size) => size.size == selectedSize)) {
          return variant.copyWith(
              availableSizeWithQuantity: sizesList
                  .where((element) => element.size != selectedSize)
                  .toList());
        } else {
          return variant.copyWith(availableSizeWithQuantity: [
            ...sizesList,
            selectedVariantFromProduct
          ]);
        }
      }
      return variant;
    }).toList();

    emit(
      state.copyWith(
        variantList: variantList,
      ),
    );
  }

  void onChangeQuantity(int selectedColor, String selectedSize, int quantity) {
    List<VariantColorSizeModel> variantList = state.variantList.map((variant) {
      if (variant.color == selectedColor) {
        List<VariantSizeQuantity> sizesList = variant.availableSizeWithQuantity;
        return variant.copyWith(
          availableSizeWithQuantity: sizesList.map(
            (size) {
              if (size.size == selectedSize) {
                return size.copyWith(quantity: quantity);
              }
              return size;
            },
          ).toList(),
        );
      }
      return variant;
    }).toList();

    emit(
      state.copyWith(
        variantList: variantList,
      ),
    );
  }

  void onChangeNote(String? note) => emit(
        state.copyWith(
          note: note,
        ),
      );

  void onChangePrice(String? price) => emit(
        state.copyWith(
          price: double.tryParse(price ?? ''),
        ),
      );

  void onAddSales() async {
    try {
      emit(state.copyWith(
          loadingState: const ProductSaleLoadingState.loading()));
      SalesProductModel salesProductModel = SalesProductModel(
        price: state.price!,
        categoryId: product.categoryId,
        productCode: product.productCode,
        selectedVariantList: state.variantList,
      );
      int totalQuantity = 0;
      for (final variant in state.variantList) {
        for (final sizeVariant in variant.availableSizeWithQuantity) {
          totalQuantity += sizeVariant.quantity;
        }
      }

      SalesDataModel salesDataModel = SalesDataModel(
        saleItemList: [salesProductModel],
        note: state.note,
        totalPrice: totalQuantity * state.price!,
        createdTime: DateTime.now(),
      );

      await _salesDataSource.addSalesToFireStore(salesDataModel);
      emit(state.copyWith(
          loadingState: const ProductSaleLoadingState.success()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
