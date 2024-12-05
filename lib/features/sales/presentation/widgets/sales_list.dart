import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';
import 'package:stock_management/features/sales/presentation/cubit/sales_cubit/sales_cubit.dart';

class SalesList extends StatefulWidget {
  const SalesList({
    super.key,
    required this.salesResponseModel,
    this.isMoreLoading = false,
  });

  final SalesResponseModel salesResponseModel;
  final bool isMoreLoading;

  @override
  State<SalesList> createState() => _ProductListState();
}

class _ProductListState extends State<SalesList> {
  final controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          widget.salesResponseModel.hasMoreData) {
        context.read<SalesCubit>().fetchMoreProducts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: widget.salesResponseModel.hasMoreData
          ? widget.salesResponseModel.salesList.length + 1
          : widget.salesResponseModel.salesList.length,
      itemBuilder: (_, i) {
        if (widget.salesResponseModel.hasMoreData &&
            i == widget.salesResponseModel.salesList.length) {
          if (widget.isMoreLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return GestureDetector(
            // onTap: () => context.router.navigate(
            //   ProductDetailRoute(
            //     product: widget.salesResponseModel.productList[i],
            //   ),
            // ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.salesResponseModel.salesList[i].note ?? ''),
                  Text(widget.salesResponseModel.salesList[i].totalPrice
                          ?.toString() ??
                      ''),
                  // Text(widget.salesResponseModel.salesList[i].),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         widget.salesResponseModel.salesList[i]
                  //             .category['categoryName'],
                  //       ),
                  //     ),
                  //     Text(
                  //         'Rs ${widget.salesResponseModel.salesList[i].totalPrice}')
                  //   ],
                  // ),
                  // Wrap(
                  //   spacing: 10,
                  //   children: availableAlphaSizes.map((availableSize) {
                  //     if (widget.salesResponseModel.productList[i]
                  //         .availableSizeWithQuantity
                  //         .containsKey(availableSize)) {
                  //       return Text(availableSize);
                  //     }
                  //     return const SizedBox();
                  //   }).toList(),
                  // )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
