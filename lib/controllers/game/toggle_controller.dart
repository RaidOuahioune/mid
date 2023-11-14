import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_full/models/game/toogle_model.dart';

class ToggleController {
  void toggle(BuildContext context, int index) {
    ToggleButtonModel viewModel =
        Provider.of<ToggleButtonModel>(context, listen: false);
    viewModel.select(index);
  }

  List<bool> selections(BuildContext context) {
    ToggleButtonModel viewModel =
        Provider.of<ToggleButtonModel>(context, listen: false);
    return viewModel.selections;
  }

  TextStyle style(BuildContext context) {
    ToggleButtonModel viewModel =
        Provider.of<ToggleButtonModel>(context, listen: false);
    return viewModel.textStyle;
  }

  void select(BuildContext context, int index) {
    ToggleButtonModel viewModel =
        Provider.of<ToggleButtonModel>(context, listen: false);
    viewModel.select(index);
  }
}
