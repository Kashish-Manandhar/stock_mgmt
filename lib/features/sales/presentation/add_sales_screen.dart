import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/core/di/injector.dart';
import 'package:stock_management/core/widgets/custom_typeahead_field.dart';
import 'package:stock_management/features/categories/data/categories_local_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

@RoutePage()
class AddSalesScreen extends StatelessWidget {
  const AddSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // CustomTypeAheadField<String>(
          //   itemBuilder: (_, value) {
          //     return Text(value);
          //   },
          //   suggestionsCallback: (search) {
          //     if(search.isNotEmpty){
          //     return Future.delayed(const Duration(milliseconds: 300), () {
          //       return getIt<CategoriesLocalSource>().getCategoriesList(query: search);
          //     });
          //
          //     }
          //     return [];
          //   },
          //   onSelected: (val) {
          //     print(val.categoryId);
          //   },
          // ),
        ],
      ),
    );
  }


}
