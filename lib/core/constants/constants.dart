import 'package:freezed_annotation/freezed_annotation.dart';

const List<String> availableAlphaSizes = [
  'S',
  'M',
  'L',
  'XL',
  'XXL',
  'XXXL',
];

const List<String> availableNumericPantSizes = [
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32'
];
const List<String> availableNumericShoesSizes = [
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42'
];

enum AvailableSize {
  @JsonValue('alphaSize')
  alphaSize,
  @JsonValue('numericShoeSize')
  numericShoeSize,
  @JsonValue('numericPantSize')
  numericPantSize
}

enum SaleFilter { daily, weekly, monthly }
