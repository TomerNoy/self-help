import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/models/breathing_state.dart';
import 'package:self_help/services/services.dart';

part 'breathing_notifier.g.dart';

@riverpod
class BreathingExercise extends _$BreathingExercise {
  static const _prepareCount = 5;
  late final int _breathInDuration;
  late final int _peakHoldDuration;
  late final int _breathOutDuration;
  late final int _baseHoldDuration;
  late final int _repeats;
  late final int _totalDuration;

  late final double _breathingInFraction;
  late final double _breathingOutFraction;

  Timer? _exercisetimer;
  Timer? _preparetimer;

  @override
  BreathingExerciseState build() {
    _repeats = storageService.readRepeats();
    _breathInDuration = storageService.readBreathInDuration();
    _peakHoldDuration = storageService.readPeakHoldDuration();
    _breathOutDuration = storageService.readBreathOutDuration();
    _baseHoldDuration = storageService.readBaseHoldDuration();
    _totalDuration = (_breathInDuration +
            _peakHoldDuration +
            _breathOutDuration +
            _baseHoldDuration) *
        _repeats;

    _breathingInFraction = 1 / _breathInDuration;
    _breathingOutFraction = 1 / _breathOutDuration;

    ref.onDispose(
      () {
        loggerService.debug('disposing breathing exercise notifier');
        _exercisetimer?.cancel();
        _preparetimer?.cancel();
      },
    );

    return BreathingExerciseState(
      breathingState: BreathingState.stopped,
      prepareCount: 0,
      totalSeconds: 0,
      stateCount: 0,
      secondsLeft: 0,
      repeatCount: 0,
      breathingScale: 0.0,
    );
  }

  void start() {
    _startPrepare();
  }

  void _startPrepare() {
    // safeguard to prevent multiple timers
    if (_preparetimer != null) {
      return;
    }

    state = state.copyWith(
      breathingState: BreathingState.prepare,
      prepareCount: _prepareCount,
    );

    _preparetimer = Timer.periodic(
      Constants.timerDuration,
      (timer) {
        if (state.prepareCount <= 1) {
          _stopPrepare();
          return _startExcercise();
        }

        state = state.copyWith(
          prepareCount: state.prepareCount - 1,
        );
      },
    );
  }

  void _startExcercise() {
    //safeguard to prevent multiple timers
    if (state.breathingState != BreathingState.prepare &&
        state.breathingState != BreathingState.stopped) {
      return;
    }

    state = state.copyWith(
      breathingState: BreathingState.breathIn,
      totalSeconds: _totalDuration,
      stateCount: _breathInDuration,
      secondsLeft: _totalDuration,
      repeatCount: _repeats,
      breathingScale: _breathingInFraction,
    );

    _exercisetimer = Timer.periodic(
      Constants.timerDuration,
      (_) {
        state = state.copyWith(
          stateCount: state.stateCount - 1,
          secondsLeft: state.secondsLeft - 1,
        );

        switch (state.breathingState) {
          case BreathingState.breathIn:
            if (state.stateCount <= 0) {
              if (_peakHoldDuration == 0) {
                _updateBreathingState(BreathingState.breathOut);
              } else {
                _updateBreathingState(BreathingState.peakHold);
              }
            } else {
              state = state.copyWith(
                breathingScale: state.breathingScale + _breathingInFraction,
              );
            }
            break;
          case BreathingState.peakHold:
            if (state.stateCount <= 0) {
              _updateBreathingState(BreathingState.breathOut);
            }
            break;
          case BreathingState.breathOut:
            if (state.stateCount <= 0) {
              if (state.repeatCount <= 1) {
                _stopExercise();
              } else if (_baseHoldDuration == 0) {
                _updateBreathingState(
                  BreathingState.breathIn,
                  repeatCount: state.repeatCount - 1,
                );
              } else {
                _updateBreathingState(
                  BreathingState.baseHold,
                  repeatCount: state.repeatCount - 1,
                );
              }
            } else {
              state = state.copyWith(
                breathingScale: state.breathingScale - _breathingOutFraction,
              );
            }
            break;
          case BreathingState.baseHold:
            if (state.repeatCount <= 1) {
              _stopExercise();
            } else if (state.stateCount <= 0) {
              _updateBreathingState(BreathingState.breathIn);
            }
            break;
          default:
            break;
        }
      },
    );
  }

  void _updateBreathingState(
    BreathingState breathingState, {
    int? repeatCount,
  }) {
    state = state.copyWith(
      breathingState: breathingState,
      stateCount: switch (breathingState) {
        BreathingState.breathIn => _breathInDuration,
        BreathingState.peakHold => _peakHoldDuration,
        BreathingState.breathOut => _breathOutDuration,
        BreathingState.baseHold => _baseHoldDuration,
        _ => 0,
      },
      breathingScale: switch (breathingState) {
        BreathingState.breathIn => state.breathingScale + _breathingInFraction,
        BreathingState.breathOut =>
          state.breathingScale - _breathingOutFraction,
        BreathingState.stopped => 0.0,
        _ => null,
      },
      repeatCount: repeatCount,
      secondsLeft: switch (breathingState) {
        BreathingState.stopped => 0,
        _ => null,
      },
    );
  }

  void stop() {
    _stopPrepare();
    _stopExercise();
  }

  void _stopPrepare() {
    _preparetimer?.cancel();
    _preparetimer = null;
  }

  void _stopExercise() {
    _exercisetimer?.cancel();
    _exercisetimer = null;
    _updateBreathingState(BreathingState.stopped, repeatCount: 0);
  }
}
