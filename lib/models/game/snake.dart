class Snake {
  final List<Cordinate> _body = [Cordinate(x: 0, y: 0)];

  List<Cordinate> get body => _body;

  void move(Cordinate newHead) {
    _body.add(newHead);
    _body.removeAt(0);
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
