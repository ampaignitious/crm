import 'package:flutter/services.dart';

class DayInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    int? value = int.tryParse(newValue.text);
    if (value == null || value < 1 || value > 31) {
      return oldValue;
    }

    return newValue;
  }
}
