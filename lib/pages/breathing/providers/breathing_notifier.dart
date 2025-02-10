import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/services/services.dart';

part 'breathing_notifier.g.dart';

enum BreathingState { stopped, breathIn, peakHold, breathOut, baseHold }

@immutable
class BreathingExerciseState {
  final BreathingState breathingState;
  final int stateCount;
  final int timerCount;
  final int repeatCount;
  final double breathingScale;

  const BreathingExerciseState({
    required this.breathingState,
    required this.stateCount,
    required this.timerCount,
    required this.repeatCount,
    required this.breathingScale,
  });

  BreathingExerciseState copyWith({
    BreathingState? breathingState,
    int? stateCount,
    int? timerCount,
    int? repeatCount,
    double? breathingScale,
  }) {
    return BreathingExerciseState(
      breathingState: breathingState ?? this.breathingState,
      stateCount: stateCount ?? this.stateCount,
      timerCount: timerCount ?? this.timerCount,
      repeatCount: repeatCount ?? this.repeatCount,
      breathingScale: breathingScale ?? this.breathingScale,
    );
  }

  @override
  String toString() {
    return '''BreathingExerciseState{
    breathingState: $breathingState, 
    stateCount: $stateCount, 
    timerCount: $timerCount, 
    repeatCount: $repeatCount
    breathingScale: $breathingScale
    }''';
  }
}

@riverpod
class BreathingExercise extends _$BreathingExercise {
  late final int _breathInDuration;
  late final int _peakHoldDuration;
  late final int _breathOutDuration;
  late final int _baseHoldDuration;
  late final int _repeats;
  late final int _totalDuration;

  late final double _breathingInFraction;
  late final double _breathingOutFraction;

  // var _breathingScale = 0.0;

  Timer? _timer;

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
        _timer?.cancel();
      },
    );

    return BreathingExerciseState(
      breathingState: BreathingState.stopped,
      stateCount: 0,
      timerCount: 0,
      repeatCount: 0,
      breathingScale: 0.0,
    );
  }

  void startTimer() {
    //safeguard to prevent multiple timers
    if (state.breathingState != BreathingState.stopped) {
      return;
    }

    state = state.copyWith(
      breathingState: BreathingState.breathIn,
      stateCount: _breathInDuration,
      timerCount: _totalDuration,
      repeatCount: _repeats,
      breathingScale: _breathingInFraction,
    );

    _timer = Timer.periodic(
      Constants.timerDuration,
      (_) {
        state = state.copyWith(
          stateCount: state.stateCount - 1,
          timerCount: state.timerCount - 1,
        );

        switch (state.breathingState) {
          case BreathingState.breathIn:
            if (state.stateCount <= 0) {
              state = state.copyWith(
                breathingState: BreathingState.peakHold,
                stateCount: _peakHoldDuration,
              );
            } else {
              state = state.copyWith(
                breathingScale: state.breathingScale + _breathingInFraction,
              );
            }
            break;
          case BreathingState.peakHold:
            if (state.stateCount <= 0) {
              state = state.copyWith(
                breathingState: BreathingState.breathOut,
                stateCount: _breathOutDuration,
                breathingScale: state.breathingScale - _breathingOutFraction,
              );
            }
            break;
          case BreathingState.breathOut:
            if (state.stateCount <= 0) {
              state = state.copyWith(
                breathingState: BreathingState.baseHold,
                stateCount: _baseHoldDuration,
              );
            } else {
              state = state.copyWith(
                breathingScale: state.breathingScale - _breathingOutFraction,
              );
            }
            break;
          case BreathingState.baseHold:
            if (state.repeatCount <= 1) {
              stop();
            } else {
              if (state.stateCount <= 0) {
                state = state.copyWith(
                  breathingState: BreathingState.breathIn,
                  stateCount: _breathInDuration,
                  repeatCount: state.repeatCount - 1,
                  breathingScale: state.breathingScale + _breathingInFraction,
                );
              }
            }

            break;
          default:
            break;
        }
      },
    );
  }

  void stop() {
    _timer?.cancel();
    state = state.copyWith(
      breathingState: BreathingState.stopped,
      stateCount: 0,
      timerCount: 0,
      repeatCount: 0,
      breathingScale: 0.0,
    );
  }
}
