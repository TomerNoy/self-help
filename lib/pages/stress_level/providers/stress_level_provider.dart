import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stress_level_provider.g.dart';

@riverpod
class StressLevel extends _$StressLevel {
  @override
  int build() => 5;

  void updateState(int value) {
    if (value < 1 || value > 10) return;
    state = value;
  }
}
