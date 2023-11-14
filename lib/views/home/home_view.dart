import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_full/models/home/home_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (context) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      minWidth: 300,
                      height: 60,
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: () => {
                        Navigator.pushNamed(context, "/game"),
                      },
                      child: const Center(
                        child: Text(
                          "click me ",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
