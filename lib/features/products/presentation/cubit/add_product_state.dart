import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

import '../../data/product_model.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(
      Product(
          productCode: '',
          category: {},
          productName: '',
          price: 0,
          availableSizeWithQuantity: {},
          createdTimeStamp: 0,
          productImage: ''),
    )
    Product product,
    @Default(AddProductLoadingState.initial())
    AddProductLoadingState addProductLoadingState,
    XFile? imageSelected,
  }) = _AddProductState;
}

@freezed
class AddProductLoadingState with _$AddProductLoadingState {
  const factory AddProductLoadingState.initial() = _InitialState;

  const factory AddProductLoadingState.loading() = _LoadingState;

  const factory AddProductLoadingState.success() = _SuccessState;

  const factory AddProductLoadingState.error(
    Exception error,
  ) = _ErrorState;
}
