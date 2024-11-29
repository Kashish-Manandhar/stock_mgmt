import 'package:flutter/material.dart';
import 'package:stock_management/core/widgets/custom_text_form_field.dart';

class QuantityFieldWithIncrementer extends StatefulWidget {
  const QuantityFieldWithIncrementer(
      {super.key,
      this.quantity,
      required this.onDecrementButtonPressed,
      required this.onIncrementButtonPressed,
      required this.onQuantityChanged,
      this.maxQuantity});

  final int? quantity;
  final Function(int) onDecrementButtonPressed;
  final Function(int) onIncrementButtonPressed;
  final Function(int) onQuantityChanged;
  final int? maxQuantity;

  @override
  State<QuantityFieldWithIncrementer> createState() =>
      _QuantityFieldWithIncrementerState();
}

class _QuantityFieldWithIncrementerState
    extends State<QuantityFieldWithIncrementer> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: widget.quantity?.toString() ?? '1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconButton(
          icon: Icons.remove,
          onButtonPressed: () {
            int quantity = int.tryParse(_textEditingController.text) ?? 0;

            quantity--;

            _textEditingController.text = quantity.toString();

            widget.onDecrementButtonPressed(quantity);
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: CustomTextFormField(
            controller: _textEditingController,
            onChanged: (val) {
              int quantity = int.tryParse(val ?? '') ?? 0;
              widget.onQuantityChanged(quantity);
            },
            validators: (val) {
              if (val == null || val.isEmpty) {
                return 'Required';
              } else {
                if (val.isEmpty) {
                  return 'Required';
                } else {
                  int quantity = int.tryParse(val) ?? 0;

                  if (quantity <= 0) {
                    return 'Quantity must not be less than 1';
                  } else if (widget.maxQuantity != null &&
                      quantity > widget.maxQuantity!) {
                    return 'Quantity must be less than or equal to  ${widget.maxQuantity}';
                  } else {
                    return null;
                  }
                }
              }
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        _iconButton(
          icon: Icons.add,
          onButtonPressed: () {
            int quantity = int.tryParse(_textEditingController.text) ?? 0;

            quantity++;

            _textEditingController.text = quantity.toString();

            widget.onIncrementButtonPressed(quantity);
          },
        ),
      ],
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onButtonPressed,
  }) =>
      InkWell(
        onTap: onButtonPressed,
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.blueAccent),
          child: Center(
            child: Icon(icon),
          ),
        ),
      );

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
