import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:stock_management/core/constants/constants.dart';
import 'package:stock_management/core/extensions/enum_extension.dart';
import 'package:stock_management/core/widgets/custom_dropdown_field.dart';
import 'package:stock_management/core/widgets/quantity_field_with_incrementer.dart';
import 'package:stock_management/features/products/data/variant_model.dart';

class InputVariantWidget extends StatefulWidget {
  const InputVariantWidget({
    super.key,
    required this.availableSize,
    required this.onChangeColor,
    required this.onChangeQuantity,
    required this.onSelectSize,
    required this.variantModel,
    required this.onAddPressed,
  });

  final AvailableSize? availableSize;
  final Function(int) onChangeColor;
  final Function(int) onChangeQuantity;
  final Function(String?) onSelectSize;
  final VariantModel variantModel;
  final VoidCallback onAddPressed;

  @override
  State<InputVariantWidget> createState() => _InputVariantWidgetState();
}

class _InputVariantWidgetState extends State<InputVariantWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField<String>(
              onChanged: widget.onSelectSize,
              items: (widget.availableSize != null)
                  ? widget.availableSize!
                      .getSizeList()
                      .map(
                        (size) => DropdownMenuItem(
                          value: size,
                          child: Text(size),
                        ),
                      )
                      .toList()
                  : [],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: widget.variantModel.color != null
                          ? Color(widget.variantModel.color!)
                          : Colors.transparent),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final result = await showDialog<Color?>(
                        context: context,
                        builder: (c) {
                          Color? color;
                          return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: BlockPicker(
                              availableColors: const [
                                Colors.white,
                                Colors.black,
                                Colors.red,
                                Colors.yellow,
                                Colors.orange,
                                Colors.purple,
                                Colors.purpleAccent,
                                Colors.green,
                                Colors.grey,
                                Colors.lime
                              ],
                              pickerColor: null,
                              onColorChanged: (val) {
                                color = val;
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  c.maybePop();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  c.maybePop(color);
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        });

                    if (result != null) {
                      widget.onChangeColor(result.value);
                    }
                  },
                  child: const Text('Pick Color'),
                ),
              ],
            ),
            QuantityFieldWithIncrementer(
              onDecrementButtonPressed: widget.onChangeQuantity,
              onIncrementButtonPressed: widget.onChangeQuantity,
              onQuantityChanged: widget.onChangeQuantity,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  if (widget.variantModel.color != null) {
                    widget.onAddPressed.call();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select color'),
                      ),
                    );
                  }
                }
              },
              child: Text('Add Variant'),
            ),
          ],
        ),
      ),
    );
  }
}
