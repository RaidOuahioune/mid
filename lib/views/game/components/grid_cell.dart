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
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: viewController.head(context) == cordinate
            ? Colors.red
            : viewController.foods(context).contains(cordinate)
                ? Colors.green
                : viewController.obstacles(context).contains(cordinate)
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
