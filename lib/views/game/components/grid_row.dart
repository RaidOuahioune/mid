import 'package:flutter/material.dart';
import 'package:snake_full/models/game/snake.dart';
import 'package:snake_full/views/game/components/grid_cell.dart';

// ignore: must_be_immutable
class GridRow extends StatelessWidget {
  int rowIndex;
  GridRow({required this.rowIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (int i = 0; i < 10; i++)
        GridCell(
          cordinate: Cordinate(x: rowIndex, y: i),
        )
    ]);
  }
}
