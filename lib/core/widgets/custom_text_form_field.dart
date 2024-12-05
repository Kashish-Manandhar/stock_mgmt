import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.validators,
    this.labelText,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
  });

  final Function(String?)? onChanged;
  final String? Function(String?)? validators;
  final String? labelText;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!),
          const SizedBox(
            height: 10,
          ),
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: maxLines,
          focusNode: focusNode,
          controller: controller,
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
          onChanged: onChanged,
          validator: validators,
        ),
      ],
    );
  }
}
