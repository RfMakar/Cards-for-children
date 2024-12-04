import 'dart:math';

class ParentalControl {
  var a = 0, b = 0;

  ParentalControl() {
    _random();
  }

  void _random() {
    final random = Random();
    a = random.nextInt(10) + 5;
    b = random.nextInt(10) + 5;
  }

  String get textExample => '$a + $b = ?';

  bool checkingTheAmount(int sum) => a + b == sum;
}
