import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:snake_full/controllers/game/game_controller.dart';
import 'package:snake_full/controllers/game/toggle_controller.dart';
import 'package:snake_full/models/game/game_model.dart';
import 'package:snake_full/models/game/toogle_model.dart';
import 'package:snake_full/views/game/components/arrow.dart';
import 'package:snake_full/views/game/components/grid_row.dart';
import 'package:snake_full/views/game/components/resume_restart.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});
  @override
  Widget build(BuildContext context) {
    GameController viewController = GameController();

    ToggleController toggleController = ToggleController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToggleButtonModel()),
        ChangeNotifierProvider(create: (_) => GameModel(xSize: 23, ySize: 10))
      ],
      child: Consumer<GameModel>(
        builder: (context, viewModel, child) {
          if (viewModel.status == GameState.gameover) {
            SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
              viewController.showGameOver(context);
            });
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResumeRestart(viewController: viewController),
                        Text(
                          "You Score: ${viewController.score(context)}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                        Consumer<ToggleButtonModel>(
                            builder: (context, viewModel, child) {
                          return Column(
                            children: [
                              ToggleButtons(
                                  isSelected:
                                      toggleController.selections(context),
                                  onPressed: (int index) {
                                    toggleController.select(context, index);
                                  },
                                  children: const [
                                    Icon(Icons.format_bold),
                                    Icon(Icons.format_italic),
                                    Icon(Icons.format_underline)
                                  ]),
                              Text(
                                  "This Is A Simple Text,Press Buttons Up And See What Gonna Happen",
                                  style: toggleController.style(context)),
                            ],
                          );
                        }),
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
