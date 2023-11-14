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

  Cordinate food(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    return viewModel.food;
  }

  List<Cordinate> body(BuildContext context) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);

    return viewModel.snake.body;
  }

  void setDirection(BuildContext context, Direction direction) {
    GameModel viewModel = Provider.of<GameModel>(context, listen: false);
    viewModel.setDirection(direction);
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
}
