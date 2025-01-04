import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/services/services.dart';

part 'breathing_notifier.g.dart';

enum BreathingType { stopped, breathIn, peakHold, breathOut, baseHold }

@immutable
class BreathingExerciseState {
  final BreathingType breathingType;
  final int timerCount;

  const BreathingExerciseState({
    required this.breathingType,
    required this.timerCount,
  });

  BreathingExerciseState copyWith({
    BreathingType? breathingType,
    bool? isPaused,
    int? timerCount,
  }) {
    return BreathingExerciseState(
      breathingType: breathingType ?? this.breathingType,
      timerCount: timerCount ?? this.timerCount,
    );
  }
}

@riverpod
class BreathingExercise extends _$BreathingExercise {
  late int _breathInDuration;
  late int _peakHoldDuration;
  late int _breathOutDuration;
  late int _baseHoldDuration;
  late int _repeats;

  late double _breathingInFraction;
  late double _breathingOutFraction;

  var _breathingScale = 0.0;

  Timer? _timer;

  double get breathingScale => _breathingScale;
  int get breathInDuration => _breathInDuration;
  int get breathOutDuration => _breathOutDuration;

  @override
  BreathingExerciseState build() {
    _repeats = storageService.readRepeats();
    _breathInDuration = storageService.readBreathInDuration();
    _peakHoldDuration = storageService.readPeakHoldDuration();
    _breathOutDuration = storageService.readBreathOutDuration();
    _baseHoldDuration = storageService.readBaseHoldDuration();

    _breathingInFraction = 1 / _breathInDuration;
    _breathingOutFraction = 1 / _breathOutDuration;

    ref.onDispose(
      () {
        loggerService.debug('disposing breathing exercise notifier');
        _timer?.cancel();
      },
    );

    return BreathingExerciseState(
      breathingType: BreathingType.stopped,
      timerCount: _breathInDuration,
    );
  }

  void startTimer() {
    //safeguard to prevent multiple timers
    if (state.breathingType != BreathingType.stopped) {
      return;
    }

    state = state.copyWith(
      breathingType: BreathingType.breathIn,
      timerCount: _breathInDuration,
    );

    var repeats = _repeats;
    _breathingScale += _breathingInFraction;

    _timer = Timer.periodic(
      Constants.timerDuration,
      (_) {
        state = state.copyWith(timerCount: state.timerCount - 1);
        loggerService.debug('_timerCount $state.timerCount');
        switch (state.breathingType) {
          case BreathingType.breathIn:
            if (state.timerCount <= 0) {
              state = state.copyWith(
                breathingType: BreathingType.peakHold,
                timerCount: _peakHoldDuration,
              );
            } else {
              _breathingScale += _breathingInFraction;
            }
            break;
          case BreathingType.peakHold:
            if (state.timerCount <= 0) {
              state = state.copyWith(
                breathingType: BreathingType.breathOut,
                timerCount: _breathOutDuration,
              );

              _breathingScale -= _breathingOutFraction;
            }
            break;
          case BreathingType.breathOut:
            if (state.timerCount <= 0) {
              state = state.copyWith(
                breathingType: BreathingType.baseHold,
                timerCount: _baseHoldDuration,
              );
            } else {
              _breathingScale -= _breathingOutFraction;
            }
            break;
          case BreathingType.baseHold:
            if (repeats <= 0) {
              stop();
            } else {
              if (state.timerCount <= 0) {
                repeats--;
                state = state.copyWith(
                  breathingType: BreathingType.breathIn,
                  timerCount: _breathInDuration,
                );
                _breathingScale += _breathingInFraction;
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
      breathingType: BreathingType.stopped,
      timerCount: _breathInDuration,
    );

    _breathingScale = 0;
  }
}

// final breathingExerciseProvider =
//     ChangeNotifierProvider.autoDispose<BreathingExerciseNotifier>(
//   (ref) => BreathingExerciseNotifier(),
// );
//
// class BreathingExerciseNotifier extends ChangeNotifier {
//   BreathingExerciseNotifier() {
//     _repeats = storageService.readRepeats();
//     _breathInDuration = storageService.readBreathInDuration();
//     _peakHoldDuration = storageService.readPeakHoldDuration();
//     _breathOutDuration = storageService.readBreathOutDuration();
//     _baseHoldDuration = storageService.readBaseHoldDuration();
//
//     _breathingInFraction = 1 / _breathInDuration;
//     _breathingOutFraction = 1 / _breathOutDuration;
//   }
//
//   /// initial params
//   late int _breathInDuration;
//   late int _peakHoldDuration;
//   late int _breathOutDuration;
//   late int _baseHoldDuration;
//   late int _repeats;
//
//   late double _breathingInFraction;
//   late double _breathingOutFraction;
//
//   /// local params
//   late int _timerCount = _breathInDuration;
//   var _breathingType = BreathingType.stopped;
//   var _breathingScale = 0.0;
//
//   Timer? _timer;
//
//   /// getters
//   int get timerCount => _timerCount;
//   BreathingType get breathingType => _breathingType;
//   double get breathingScale => _breathingScale;
//   int get breathInDuration => _breathInDuration;
//   int get breathOutDuration => _breathOutDuration;
//
//   void stop() {
//     _timer?.cancel();
//     _timerCount = _breathInDuration;
//     _breathingType = BreathingType.stopped;
//     _breathingScale = 0;
//     notifyListeners();
//   }
//
//   void startTimer() {
//     //safeguard to prevent multiple timers
//     if (_breathingType != BreathingType.stopped) {
//       return;
//     }
//
//     _breathingType = BreathingType.breathIn;
//     var repeats = _repeats;
//     _timerCount = _breathInDuration;
//     _breathingScale += _breathingInFraction;
//     notifyListeners();
//
//     _timer = Timer.periodic(
//       Constants.timerDuration,
//       (_) {
//         _timerCount--;
//         loggerService.debug('_timerCount $_timerCount');
//         switch (_breathingType) {
//           case BreathingType.breathIn:
//             if (_timerCount <= 0) {
//               _timerCount = _peakHoldDuration;
//               _breathingType = BreathingType.peakHold;
//             } else {
//               _breathingScale += _breathingInFraction;
//             }
//             break;
//           case BreathingType.peakHold:
//             if (_timerCount <= 0) {
//               _timerCount = _breathOutDuration;
//               _breathingType = BreathingType.breathOut;
//               _breathingScale -= _breathingOutFraction;
//             }
//             break;
//           case BreathingType.breathOut:
//             if (_timerCount <= 0) {
//               _timerCount = _baseHoldDuration;
//               _breathingType = BreathingType.baseHold;
//             } else {
//               _breathingScale -= _breathingOutFraction;
//             }
//             break;
//           case BreathingType.baseHold:
//             if (repeats <= 0) {
//               stop();
//             } else {
//               if (_timerCount <= 0) {
//                 repeats--;
//                 _timerCount = _breathInDuration;
//                 _breathingType = BreathingType.breathIn;
//                 _breathingScale += _breathingInFraction;
//               }
//             }
//
//             break;
//           default:
//             break;
//         }
//         notifyListeners();
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     loggerService.debug('disposing breathing exercise notifier');
//     _timer?.cancel();
//     super.dispose();
//   }
// }
