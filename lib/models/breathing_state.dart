import 'package:flutter/material.dart';

enum BreathingState {
  stopped,
  prepare,
  breathIn,
  peakHold,
  breathOut,
  baseHold,
}

@immutable
class BreathingExerciseState {
  final BreathingState breathingState;
  final int prepareCount;
  final int totalSeconds;
  final int stateCount;
  final int secondsLeft;
  final int repeatCount;
  final double breathingScale;

  const BreathingExerciseState({
    required this.breathingState,
    required this.prepareCount,
    required this.totalSeconds,
    required this.stateCount,
    required this.secondsLeft,
    required this.repeatCount,
    required this.breathingScale,
  });

  BreathingExerciseState copyWith({
    BreathingState? breathingState,
    int? prepareCount,
    int? totalSeconds,
    int? stateCount,
    int? secondsLeft,
    int? repeatCount,
    double? breathingScale,
  }) {
    return BreathingExerciseState(
      breathingState: breathingState ?? this.breathingState,
      prepareCount: prepareCount ?? this.prepareCount,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      stateCount: stateCount ?? this.stateCount,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      repeatCount: repeatCount ?? this.repeatCount,
      breathingScale: breathingScale ?? this.breathingScale,
    );
  }

  @override
  String toString() {
    return '''BreathingExerciseState{
    breathingState: $breathingState, 
    prepareCount: $prepareCount,
    totalSeconds: $totalSeconds,
    stateCount: $stateCount, 
    secondsLeft: $secondsLeft, 
    repeatCount: $repeatCount
    breathingScale: $breathingScale
    }''';
  }
}
