extension SizeNameExtension on String? {
  String getSizeName() {
    switch (this) {
      case 'S':
        return 'Small';
      case 'M':
        return 'Medium';
      case 'L':
        return 'Large';
      case 'XL':
        return 'Extra Large';
      case 'XXL':
        return 'Double XL';
      case 'XXXL':
        return 'Triple XL';

      default:
        return this ?? '';
    }
  }
}
