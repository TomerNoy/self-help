import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/services/services.dart';

final breathingExerciseProvider =
    ChangeNotifierProvider.autoDispose<BreathingExerciseNotifier>(
  (ref) => BreathingExerciseNotifier(),
);

enum BreathingType { stopped, breathIn, peakHold, breathOut, baseHold }

class BreathingExerciseNotifier extends ChangeNotifier {
  BreathingExerciseNotifier() {
    _repeats = storageService.getRepeats();
    _breathInDuration = storageService.getBreathInDuration();
    _peakHoldDuration = storageService.getPeakHoldDuration();
    _breathOutDuration = storageService.getBreathOutDuration();
    _baseHoldDuration = storageService.getBaseHoldDuration();

    _breathingInFraction = 1 / _breathInDuration;
    _breathingOutFraction = 1 / _breathOutDuration;
  }

  /// initial params
  late int _breathInDuration;
  late int _peakHoldDuration;
  late int _breathOutDuration;
  late int _baseHoldDuration;
  late int _repeats;

  late double _breathingInFraction;
  late double _breathingOutFraction;

  /// local params
  late int _timerCount = _breathInDuration;
  var _timerOn = false;
  var _breathingType = BreathingType.stopped;
  var _breathingScale = 0.0;

  /// getters
  int get elapsedTime => _timerCount;
  bool get timerOn => _timerOn;
  BreathingType get breathingType => _breathingType;
  double get breathingScale => _breathingScale;
  int get breathInDuration => _breathInDuration;
  int get breathOutDuration => _breathOutDuration;

  void stop() {
    _timer?.cancel();
    _timerCount = _breathInDuration;
    _timerOn = false;
    _breathingType = BreathingType.stopped;
    _breathingScale = 0;
    notifyListeners();
  }

  Timer? _timer;

  void startTimer() {
    //safeguard to prevent multiple timers
    if (_timerOn) {
      return;
    } else {
      _timerOn = true;
    }

    _breathingType = BreathingType.breathIn;
    var repeats = _repeats;
    _timerCount = _breathInDuration;
    _breathingScale += _breathingInFraction;
    notifyListeners();

    _timer = Timer.periodic(
      Constants.timerDuration,
      (_) {
        _timerCount--;
        print('_timerCount $_timerCount');
        switch (_breathingType) {
          case BreathingType.breathIn:
            if (_timerCount <= 0) {
              _timerCount = _peakHoldDuration;
              _breathingType = BreathingType.peakHold;
            } else {
              _breathingScale += _breathingInFraction;
            }
            break;
          case BreathingType.peakHold:
            if (_timerCount <= 0) {
              _timerCount = _breathOutDuration;
              _breathingType = BreathingType.breathOut;
              _breathingScale -= _breathingOutFraction;
            }
            break;
          case BreathingType.breathOut:
            if (_timerCount <= 0) {
              _timerCount = _baseHoldDuration;
              _breathingType = BreathingType.baseHold;
            } else {
              _breathingScale -= _breathingOutFraction;
            }
            break;
          case BreathingType.baseHold:
            if (repeats <= 0) {
              stop();
            } else {
              if (_timerCount <= 0) {
                repeats--;
                _timerCount = _breathInDuration;
                _breathingType = BreathingType.breathIn;
                _breathingScale += _breathingInFraction;
              }
            }

            break;
          default:
            break;
        }
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    loggerService.debug('disposing breathing exercise notifier');
    _timer?.cancel();
    super.dispose();
  }
}
