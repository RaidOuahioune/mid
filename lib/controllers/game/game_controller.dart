import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_full/models/game/game_model.dart';
import 'package:snake_full/models/game/snake.dart';

class GameController {
  GameController();

  Cordinate head(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.snake.body.last;
  }

  List<Cordinate> foods(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.foods;
  }

  List<Cordinate> obstacles(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);

    return viewModel.obstacles;
  }

  List<Cordinate> body(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);

    return viewModel.snake.body;
  }

  void move(BuildContext context, Direction direction) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);

    viewModel.move(direction);
  }

  void showGameOver(BuildContext context,
      {String message = "GameOver.Click here to restart"}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        action: SnackBarAction(
          label: "Restart",
          onPressed: () {
            GameModel viewModel =
                Provider.of<GameModel>(context, listen: false);
            viewModel.restart();
          },
        ),
      ),
    );
  }

  void howHighScoreBeaten(BuildContext context,
      {String message =
          "New Score achieved . Congratulation !!. Click here to restart"}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(message),
        action: SnackBarAction(
          label: "Restart",
          onPressed: () {
            GameModel viewModel =
                Provider.of<GameModel>(context, listen: false);
            viewModel.restart();
          },
        ),
      ),
    );
  }

  int score(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.score;
  }

  void resume(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    viewModel.resume();
  }

  void pause(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    viewModel.pause();
  }

  void restart(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    viewModel.restart();
  }

  GameState gameState(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.status;
  }

  double speed(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return (1.1 - viewModel.speed) * 10;
  }

  int highestScore(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.highestScore;
  }
}
