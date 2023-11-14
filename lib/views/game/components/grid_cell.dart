import 'package:flutter/material.dart';
import 'package:snake_full/controllers/game/game_controller.dart';
import 'package:snake_full/models/game/snake.dart';

// ignore: must_be_immutable
class GridCell extends StatelessWidget {
  Cordinate cordinate;
  GridCell({required this.cordinate, super.key});

  @override
  Widget build(BuildContext context) {
    GameController viewController = GameController();
    return Container(
      width: 32,
      height: 20,
      decoration: BoxDecoration(
        color: viewController.head(context) == cordinate
            ? Colors.red
            : viewController.food(context) == cordinate
                ? Colors.green
                : viewController.body(context).contains(cordinate)
                    ? Colors.blue
                    : Colors.black,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
    );
  }
}
