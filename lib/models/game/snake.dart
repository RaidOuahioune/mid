class Snake {
  final List<Cordinate> _body = [Cordinate(x: 0, y: 0)];

  List<Cordinate> get body => _body;
  void eat(Cordinate food) {
    _body.insert(0, food);
  }

  void move(Cordinate newHead) {
    _body.add(newHead);
    _body.removeAt(0);
  }

  bool isDead() {
    return _body.reversed.toList().sublist(1).contains(_body.last);
  }
}

class Cordinate {
  int x;
  int y;
  Cordinate({required this.x, required this.y});
  @override
  operator ==(Object other) {
    if (other is Cordinate) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(x, y);
}
