
import 'package:flutter/material.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';
import 'package:stock_management/features/sales/presentation/widgets/sales_item_list.dart';

class SalesList extends StatefulWidget {
  const SalesList({
    super.key,
    required this.salesResponseModel,
    this.isMoreLoading = false,
    this.onLoadingMoreFunction,
  });

  final SalesResponseModel salesResponseModel;
  final bool isMoreLoading;
  final VoidCallback? onLoadingMoreFunction;

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
        widget.onLoadingMoreFunction?.call();
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
          return SalesItemList(salesDataModel: widget.salesResponseModel.salesList[i],
          );
        }
      },
    );
  }
}
