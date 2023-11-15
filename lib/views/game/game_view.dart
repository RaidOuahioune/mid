import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:snake_full/controllers/game/game_controller.dart';
import 'package:snake_full/models/game/game_model.dart';
import 'package:snake_full/views/game/components/arrow.dart';
import 'package:snake_full/views/game/components/grid_row.dart';
import 'package:snake_full/views/game/components/resume_restart.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});
  @override
  Widget build(BuildContext context) {
    GameController viewController = GameController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameModel(xSize: 23, ySize: 20))
      ],
      child: Consumer<GameModel>(
        builder: (context, viewModel, child) {
          if (viewModel.status == GameState.gameover) {
            SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
              viewController.showGameOver(context);
            });
          } else if (viewModel.status == GameState.highscore) {
            SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
              viewController.howHighScoreBeaten(context);
            });
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResumeRestart(viewController: viewController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Score: ${viewController.score(context)}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Highest Score : ${viewModel.highestScore}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          "Current Speed: x${viewModel.speed}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        for (int j = 0; j < 23; j++) GridRow(rowIndex: j),
                        MaterialButton(
                          onPressed: () => {Navigator.pop(context)},
                          textColor: Colors.white,
                          color: Colors.black,
                          child: const Text("Go Back"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Arrow(icon: Icons.keyboard_arrow_up),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Arrow(icon: Icons.keyboard_arrow_left),
                              Arrow(icon: Icons.keyboard_arrow_right)
                            ],
                          ),
                        ),
                        Arrow(icon: Icons.keyboard_arrow_down),
                        const SizedBox(width: 200, height: 200),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
