import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (_state == 0) return;
    _state--;
    notifyListeners();
  }

  set state(int value) {
    _state = value;
    notifyListeners();
  }
}

final levelProvider =
    ChangeNotifierProvider.autoDispose<CounterNotifier>((ref) {
  return CounterNotifier();
});
