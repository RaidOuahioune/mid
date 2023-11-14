import 'package:flutter/material.dart';
import 'package:snake_full/controllers/game/game_controller.dart';
import 'package:snake_full/models/game/game_model.dart';

class ResumeRestart extends StatelessWidget {
  final GameController viewController;

  const ResumeRestart({
    super.key,
    required this.viewController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => {
                  if (viewController.gameState(context) == GameState.pause)
                    viewController.resume(context)
                  else
                    viewController.pause(context)
                },
            icon: Icon(viewController.gameState(context) == GameState.pause
                ? Icons.play_arrow
                : Icons.pause)),
        IconButton(
            onPressed: () => {viewController.restart(context)},
            icon: const Icon(Icons.restart_alt))
      ],
    );
  }
}
