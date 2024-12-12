import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/features/products/data/product_response_model.dart';
import 'package:stock_management/features/products/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:stock_management/features/products/presentation/widgets/product_item_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
    required this.productResponseModel,
    this.isMoreLoading = false,
  });

  final ProductResponseModel productResponseModel;
  final bool isMoreLoading;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          widget.productResponseModel.hasMoreData) {
        context.read<ProductCubit>().fetchMoreProducts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: widget.productResponseModel.hasMoreData
          ? widget.productResponseModel.productList.length + 1
          : widget.productResponseModel.productList.length,
      itemBuilder: (_, i) {
        if (widget.productResponseModel.hasMoreData &&
            i == widget.productResponseModel.productList.length) {
          if (widget.isMoreLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return ProductItemWidget(
            product: widget.productResponseModel.productList[i],
          );
        }
      },
    );
  }
}
