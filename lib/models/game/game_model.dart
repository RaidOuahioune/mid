import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snake_full/models/game/snake.dart';

enum Direction { up, down, left, right }

enum GameState { playing, pause, gameover }

class GameModel extends ChangeNotifier {
  int xSize, ySize;
  GameState status = GameState.playing;
  int _score = 0;
  int get score => _score;
  late Cordinate food;
  late Timer _timer;
  Direction direction = Direction.right; //right,
  Snake snake = Snake();
  int x = 0; //head
  int y = 0;
  GameModel({required this.xSize, required this.ySize}) {
    generateFood();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (t) {
      move();
    });
  }

  Cordinate _move() {
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

  void move() {
    Cordinate newHead = _move();
    if (newHead == food) {
      snake.eat(food);
      _score++;
      generateFood();
    }
    snake.move(newHead);
    if (snake.isDead()) {
      status = GameState.gameover;
      _timer.cancel();
    }
    notifyListeners();
  }

  void generateFood() {
    while (true) {
      int xFood = Random().nextInt(xSize);
      int yFood = Random().nextInt(ySize);
      food = Cordinate(x: xFood, y: yFood);
      bool inSnake = false;

      for (Cordinate snakeCell in snake.body) {
        if (snakeCell == food) {
          inSnake = true;
          break;
        }
      }
      if (inSnake) {
        continue;
      } else {
        return;
      }
    }
  }

  void setDirection(Direction direction) {
    if (direction == Direction.up && this.direction == Direction.down) return;
    if (direction == Direction.down && this.direction == Direction.up) return;
    if (direction == Direction.left && this.direction == Direction.right) {
      return;
    }
    if (direction == Direction.right && this.direction == Direction.left) {
      return;
    }
    this.direction = direction;
    notifyListeners();
  }

  void restart() {
    snake = Snake();
    x = 0;
    y = 0;
    direction = Direction.right;
    _score = 0;
    generateFood();
    resume();
  }

  void pause() {
    _timer.cancel();
    status = GameState.pause;
    notifyListeners();
  }

  void resume() {
    status = GameState.playing;
    notifyListeners();
    _timer.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (t) {
      move();
    });
  }
}
