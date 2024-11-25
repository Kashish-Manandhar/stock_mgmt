import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';

class CustomTypeAheadField<T> extends StatelessWidget {
  const CustomTypeAheadField({
    super.key,
    required this.onSelected,
    required this.itemBuilder,
    required this.suggestionsCallback,
    this.textEditingController,
  });

  final void Function(T) onSelected;
  final Widget Function(BuildContext, T) itemBuilder;
  final FutureOr<List<T>?> Function(String) suggestionsCallback;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      debounceDuration: const Duration(milliseconds: 500),
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      suggestionsCallback: suggestionsCallback,
      controller: textEditingController,
      builder: (context, controller, focusNode) => CustomTextFormField(
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }
}
