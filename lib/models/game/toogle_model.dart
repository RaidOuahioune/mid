import 'package:flutter/material.dart';

class ToggleButtonModel extends ChangeNotifier {
  final List<bool> _selections = [false, false, false];

  List<bool> get selections => _selections;

  TextStyle _style = const TextStyle();

  TextStyle get textStyle => _style;

  void select(int index) {
    FontWeight txtBold = FontWeight.normal;
    FontStyle txtItalic = FontStyle.normal;
    TextDecoration txtUnder = TextDecoration.none;
    _selections[index] = !_selections[index];
    if (index == 0 && _selections[index]) {
      txtBold = FontWeight.bold;
    } else if (index == 0 && !_selections[index]) {
      txtBold = FontWeight.normal;
    }

    if (index == 1 && _selections[index]) {
      txtItalic = FontStyle.italic;
    } else if (index == 1 && !_selections[index]) {
      txtItalic = FontStyle.normal;
    }

    if (index == 2 && _selections[index]) {
      txtUnder = TextDecoration.underline;
    } else if (index == 2 && !_selections[index]) {
      txtUnder = TextDecoration.none;
    }
    _style = TextStyle(
        fontWeight: txtBold, fontStyle: txtItalic, decoration: txtUnder);
    notifyListeners();
  }
}
