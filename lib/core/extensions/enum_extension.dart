import 'package:stock_management/core/constants/constants.dart';

extension XAvailableSize on AvailableSize {
  String getStringValue() {
    switch (this) {
      case AvailableSize.alphaSize:
        return 'Alpha Size (Eg: S,M.L)';
      case AvailableSize.numericPantSize:
        return 'Pant Size (Eg:26,27)';
      case AvailableSize.numericShoeSize:
        return 'Shoes Size (Eg:36,37)';
    }
  }

  List<String> getSizeList() {
    switch (this) {
      case AvailableSize.alphaSize:
        return availableAlphaSizes;
      case AvailableSize.numericPantSize:
        return availableNumericPantSizes;
      case AvailableSize.numericShoeSize:
        return availableNumericShoesSizes;
    }
  }
}
