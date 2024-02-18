import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final value = double.tryParse(cleanedText) ?? 0.0;
    final newText = (value / 100).toStringAsFixed(2);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}
