import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/models/stress_track.dart';
import 'package:self_help/services/services.dart';

part 'stress_level_provider.g.dart';

@riverpod
class StressLevel extends _$StressLevel {
  @override
  int build() => 5;

  void updateState(int value) {
    if (value < 1 || value > 10) return;
    state = value;
  }

  void addStressTrack(StressTrack track) {
    final result = userDataService.addStressTrack(track);
    loggerService.debug('Stress track added: $result');
  }
}
