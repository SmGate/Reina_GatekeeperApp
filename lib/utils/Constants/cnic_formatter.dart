import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.length > 3 && newText.length <= 5) {
      newText = newText.substring(0, 5) + '-' + newText.substring(5);
    }

    if (newText.length > 12 && newText.length <= 19) {
      newText = newText.substring(0, 13) + '-' + newText.substring(13);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
