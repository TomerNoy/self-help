import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stressLevelProvider =
    ChangeNotifierProvider.autoDispose<CounterNotifier>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends ChangeNotifier {
  CounterNotifier();

  int _state = 5;

  int get state => _state;

  void increment() {
    if (_state == 10) return;
    _state++;
    notifyListeners();
  }

  void decrement() {
    if (_state == 1) return;
    _state--;
    notifyListeners();
  }

  set state(int value) {
    if (value < 1 || value > 10) return;
    _state = value;
    notifyListeners();
  }
}
