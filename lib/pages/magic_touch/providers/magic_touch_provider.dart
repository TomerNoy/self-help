import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/services/services.dart';

part 'magic_touch_provider.g.dart';

class TimerState {
  final int count;
  final bool isFinished;
  final bool isActive;

  TimerState({
    this.count = 0,
    this.isFinished = false,
    this.isActive = false,
  });

  TimerState copyWith({
    int? count,
    bool? isFinished,
    bool? isActive,
  }) {
    return TimerState(
      count: count ?? this.count,
      isFinished: isFinished ?? this.isFinished,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  toString() {
    return 'TimerState(count: $count, isFinished: $isFinished, isActive: $isActive)';
  }
}

@riverpod
class MagicTouch extends _$MagicTouch {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(
      () {
        loggerService.debug('disposing magic touch notifier');
        _timer?.cancel();
        _timer = null;
      },
    );
    return TimerState();
  }

  void startTimer() {
    if (state.isActive) return;

    state = state.copyWith(isActive: true);

    _timer = Timer.periodic(
      Constants.timerDuration,
      (ticker) {
        if (state.count == 30) {
          _cancelTimer();
          state = state.copyWith(
            isFinished: true,
            count: 0,
            isActive: false,
          );

          return;
        }
        state = state.copyWith(
          count: ticker.tick,
        );
      },
    );
  }

  void toggleTimer() {
    if (state.isActive) {
      _cancelTimer();
    } else {
      startTimer();
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void stop() {
    _cancelTimer();
    state = state.copyWith(
      isActive: false,
      count: 0,
    );
  }
}
