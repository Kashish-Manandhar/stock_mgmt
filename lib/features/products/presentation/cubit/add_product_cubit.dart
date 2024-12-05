import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/helpers/image_upload_helper.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/products/data/product_data_source.dart';
import 'package:stock_management/features/products/data/product_model.dart';
import 'package:stock_management/features/products/data/variant_model.dart';
import 'package:stock_management/features/products/presentation/cubit/add_product_state.dart';

@injectable
class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit({
    required this.productDataSource,
    required this.imageUploadHelper,
    @factoryParam this.product,
    @factoryParam this.categoriesList = const [],
  }) : super(const AddProductState());

  final ProductDataSource productDataSource;
  final Product? product;
  final ImageUploadHelper imageUploadHelper;
  final List<CategoriesModel> categoriesList;

  @postConstruct
  void feedData() {
    if (product != null) {
      final selectedCategory = categoriesList
          .firstWhere((element) => element.categoryId == product!.categoryId);
      emit(
        state.copyWith(
          product: product!,
          selectedVariant: product?.variantList ?? [],
          selectedCategory: selectedCategory,
        ),
      );
    }
  }

  void onChangeProductCode(String? prodCode) =>
      emit(state.copyWith.product(productCode: prodCode!));

  void onChangeProductName(String? productName) =>
      emit(state.copyWith.product(productName: productName!));

  void onChangeProductPrice(String? price) =>
      emit(state.copyWith.product(price: double.tryParse(price ?? '') ?? 0));

  void onChangeCategory(CategoriesModel? category) =>
      emit(state.copyWith(selectedCategory: category));

  void onChangeImage(XFile? file) {
    emit(
      state.copyWith(
        imageSelected: file,
      ),
    );
  }

  void onAddColor(int color) {
    List<VariantColorSizeModel> availableColorWithSize =
        state.selectedVariant.toList();

    if (availableColorWithSize
        .any((colorWithSize) => colorWithSize.color == color)) {
      //we need to throw exception a
    } else {
      availableColorWithSize.add(VariantColorSizeModel(color: color));
    }

    emit(state.copyWith(selectedVariant: availableColorWithSize));
  }

  void onSelectSize(int color, String size) {
    List<VariantColorSizeModel> availableColorWithSize =
        state.selectedVariant.map((variant) {
      if (variant.color == color) {
        List<VariantSizeQuantity> sizeList =
            variant.availableSizeWithQuantity.toList();

        if (sizeList.any((availableSizes) => availableSizes.size == size)) {
          return variant.copyWith(
              availableSizeWithQuantity:
                  sizeList.where((sizes) => sizes.size != size).toList());
        } else {
          return variant.copyWith(availableSizeWithQuantity: [
            ...sizeList,
            VariantSizeQuantity(size: size)
          ]);
        }
      }
      return variant;
    }).toList();

    emit(state.copyWith(selectedVariant: availableColorWithSize));
  }

  void onChangeQuantity(int color, String size, int quantity) {
    List<VariantColorSizeModel> availableColorWithSize =
        state.selectedVariant.map((variant) {
      if (variant.color == color) {
        return variant.copyWith(
            availableSizeWithQuantity:
                variant.availableSizeWithQuantity.map((sizes) {
          if (sizes.size == size) {
            return sizes.copyWith(quantity: quantity);
          }
          return sizes;
        }).toList());
      }
      return variant;
    }).toList();

    emit(state.copyWith(selectedVariant: availableColorWithSize));
  }

  Future<void> _addOrEditProduct(
      {required Product product, bool isEdit = false}) async {
    try {
      await productDataSource.addProduct(
        product: isEdit
            ? product.copyWith(
                variantList: state.selectedVariant,
              )
            : product.copyWith(
                categoryId: state.selectedCategory?.categoryId ?? '',
                variantList: state.selectedVariant,
                createdTimeStamp: DateTime.now().millisecondsSinceEpoch),
        isEdit: isEdit,
      );

      emit(
        state.copyWith(
            addProductLoadingState: const AddProductLoadingState.success()),
      );
    } catch (error) {
      emit(
        state.copyWith(
          addProductLoadingState:
              AddProductLoadingState.error(error as Exception),
        ),
      );
    }
  }

  void onAddProduct() async {
    emit(
      state.copyWith(
          addProductLoadingState: const AddProductLoadingState.loading()),
    );

    await _addOrEditProduct(product: state.product, isEdit: product != null);
  }
}
