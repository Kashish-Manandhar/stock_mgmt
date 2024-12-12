import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/products/data/variant_model.dart';

import '../../data/product_model.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(
      Product(
        productCode: '',
        productName: '',
        price: 0,
        createdTimeStamp: 0,
        productImage: '',
        categoryId: '',
      ),
    )
    Product product,
    @Default(AddProductLoadingState.initial())
    AddProductLoadingState addProductLoadingState,
    XFile? imageSelected,
    @Default([]) List<VariantColorSizeModel> selectedVariant,
    CategoriesModel? selectedCategory,
  }) = _AddProductState;
}

@freezed
class AddProductLoadingState with _$AddProductLoadingState {
  const factory AddProductLoadingState.initial() = _InitialState;

  const factory AddProductLoadingState.loading() = _LoadingState;

  const factory AddProductLoadingState.success(Product product) = _SuccessState;

  const factory AddProductLoadingState.error(
    Exception error,
  ) = _ErrorState;
}
