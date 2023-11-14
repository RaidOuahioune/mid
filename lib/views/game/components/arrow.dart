import 'package:flutter/material.dart';
import 'package:snake_full/controllers/game/game_controller.dart';
import 'package:snake_full/models/game/game_model.dart';

// ignore: must_be_immutable
class Arrow extends StatelessWidget {
  IconData icon;
  Arrow({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    GameController viewController = GameController();
    return MaterialButton(
      textColor: Colors.white,
      color: Colors.black,
      onPressed: () => {
        if (icon == Icons.keyboard_arrow_up)
          viewController.setDirection(context, Direction.up)
        else if (icon == Icons.keyboard_arrow_down)
          viewController.setDirection(context, Direction.down)
        else if (icon == Icons.keyboard_arrow_left)
          viewController.setDirection(context, Direction.left)
        else if (icon == Icons.keyboard_arrow_right)
          viewController.setDirection(context, Direction.right),
        print("arrow")
      },
      child: Icon(icon),
    );
  }
}
