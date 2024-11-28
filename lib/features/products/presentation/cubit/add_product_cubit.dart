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
  }) : super(const AddProductState());

  final ProductDataSource productDataSource;
  final Product? product;
  final ImageUploadHelper imageUploadHelper;

  @postConstruct
  void feedData() {
    if (product != null) {
      emit(state.copyWith(product: product!));
    }
  }

  void onChangeProductCode(String? prodCode) =>
      emit(state.copyWith.product(productCode: prodCode!));

  void onChangeProductName(String? productName) =>
      emit(state.copyWith.product(productName: productName!));

  void onChangeProductPrice(String? price) =>
      emit(state.copyWith.product(price: double.tryParse(price ?? '') ?? 0));

  void onChangeCategory(CategoriesModel? category) =>
      emit(state.copyWith.product(category: category?.toJson() ?? {}));

  void onChangeImage(XFile? file) {
    emit(
      state.copyWith(
        imageSelected: file,
      ),
    );
  }

  void onAddVariant(VariantModel variantModel) {
    List<VariantModel> variantList=state.product.variantList.toList();
    emit(
      state.copyWith.product(
        variantList: variantList..add(variantModel),
      ),
    );
  }

  Future<void> _addOrEditProduct(
      {required Product product, bool isEdit = false}) async {
    try {
      await productDataSource.addProduct(
        product: isEdit
            ? product
            : product.copyWith(
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
    // if (product == null && state.imageSelected == null) {
    //   emit(
    //     state.copyWith(
    //       addProductLoadingState: AddProductLoadingState.error(
    //         Exception('Please select image first'),
    //       ),
    //     ),
    //   );
    //
    //   return;
    // }
    //String? imageUrl;
    emit(
      state.copyWith(
          addProductLoadingState: const AddProductLoadingState.loading()),
    );
    //
    // if (state.imageSelected != null) {
    //   imageUrl = await imageUploadHelper.uploadImage(
    //       image: state.imageSelected,
    //       collectionName: 'products',
    //       documentName: state.productCode!);
    // }

     await _addOrEditProduct(product: state.product, isEdit: product != null);

    // print(state.product.toJson());
  }
}
