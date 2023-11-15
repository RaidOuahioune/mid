import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snake_full/models/game/snake.dart';

enum Direction { up, down, left, right }

enum GameState { playing, pause, gameover, highscore }

class GameModel extends ChangeNotifier {
  int xSize, ySize;

  double speed = 1;
  GameState status = GameState.playing;
  int _score = 0;
  int get score => _score;
  late Timer _timer;

  int obstacleNumber = 1;

  int highestScore = 0;

  int foodInterval = 0;

  List<Cordinate> obstacles = [];
  List<Cordinate> foods = [];
  Snake snake = Snake();
  int x = 0; //head
  int y = 0;

  GameModel({required this.xSize, required this.ySize}) {
    _timer =
        Timer.periodic(Duration(milliseconds: (1000 * speed).toInt()), (t) {
      _int();
    });
  }

  void _int() {
    if (foodInterval == 0) {
      generateFoods();
    }
    foodInterval++;
    foodInterval %= 5;
    controlFood();
    controlObstacles();
  }

  Cordinate _move(Direction direction) {
    switch (direction) {
      case Direction.up:
        x--;
        x %= xSize;
        break;
      case Direction.down:
        x++;
        x %= xSize;
        break;
      case Direction.left:
        y--;
        y %= ySize;
        break;
      case Direction.right:
        y++;
        y %= ySize;
        break;
    }
    return Cordinate(x: x, y: y);
  }

  void move(Direction direction) {
    if (status == GameState.gameover || status == GameState.highscore) {
      return;
    }
    Cordinate newHead = _move(direction);
    snake.move(newHead);
    checkSnakeCollision();
    chechFoodEating();
    notifyListeners();
  }

  void generateFoods() {
    while (true) {
      int xFood = Random().nextInt(xSize);
      Cordinate newfood = Cordinate(x: xFood, y: ySize);
      if (newfood != snake.body.last && !isCellInBody(newfood, foods)) {
        foods.add(newfood);
        break;
      }
      notifyListeners();
    }
  }

  bool isCellInBody(Cordinate cell, List<Cordinate> body) {
    for (Cordinate bodyCell in body) {
      if (cell == bodyCell) {
        return true;
      }
    }
    return false;
  }

  void restart() {
    snake = Snake();
    x = 0;
    y = 0;
    speed = 1;
    obstacles = [];
    foods = [];
    _score = 0;
    resume();
  }

  void pause() {
    _timer.cancel();
    status = GameState.pause;
    notifyListeners();
  }

  void resume({double speed = 1}) {
    status = GameState.playing;
    notifyListeners();
    _timer.cancel();
    _timer =
        Timer.periodic(Duration(milliseconds: (1000 * speed).toInt()), (t) {
      _int();
    });
  }

  void generateObstacles() {
    List<Cordinate> newObstacles = [];
    for (int i = 0; i < obstacleNumber; i++) {
      int xObstacle = Random().nextInt(xSize);
      Cordinate obstacle = Cordinate(x: xObstacle, y: ySize);
      if (!isCellInBody(obstacle, newObstacles)) {
        obstacles.add(obstacle);
      }
    }
    obstacles.addAll(newObstacles);
  }

  void removerObstacles() {
    List<Cordinate> newObstacles = obstacles.toList();
    for (Cordinate obstacle in newObstacles) {
      if (obstacle.y < 0) {
        newObstacles.remove(obstacle);
      }
    }
    obstacles = newObstacles;
  }

  void removerFood() {
    List<Cordinate> newFoods = foods.toList();
    for (Cordinate food in newFoods) {
      if (food.y < 0) {
        newFoods.remove(food);
      }
    }
    foods = newFoods;
  }

  void moveObstacles() {
    for (Cordinate obstacle in obstacles) {
      obstacle.y--;
    }
  }

  void moveFoods() {
    for (Cordinate food in foods) {
      food.y--;
    }
  }

  void newObstackles() {
    generateObstacles();
    moveObstacles();
    notifyListeners();
  }

  void controlFood() {
    moveFoods();
    chechFoodEating();
  }

  void controlObstacles() {
    newObstackles();
    checkSnakeCollision();
  }

  void checkSnakeCollision() {
    for (Cordinate obstacle in obstacles) {
      if (obstacle == snake.body.last) {
        status = GameState.gameover;

        if (score > highestScore) {
          status = GameState.highscore;
          highestScore = score;
        }
        _timer.cancel();
        return;
      }
    }
    notifyListeners();
  }

  void chechFoodEating() {
    for (Cordinate food in foods) {
      if (food == snake.body.last) {
        food.y = -20;
        _score++;
        if (score % 10 == 0) {
          speed -= 0.1;
          _timer.cancel();
          _timer = Timer.periodic(
              Duration(milliseconds: (1000 * speed).toInt()), (t) {
            _int();
          });
          return;
        }
      }
      notifyListeners();
    }
  }
}
