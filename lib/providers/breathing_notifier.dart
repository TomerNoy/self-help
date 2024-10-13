import 'dart:async';

import 'package:flutter/material.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/services/services.dart';

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
  var _timerCount = 0;
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
    _timerCount = 0;
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
    notifyListeners();

    _timer = Timer.periodic(
      Constants.timerDuration,
      (_) {
        _timerCount--;
        switch (_breathingType) {
          case BreathingType.breathIn:
            _breathingScale += _breathingInFraction;
            if (_timerCount < 0) {
              _timerCount = _peakHoldDuration;
              _breathingType = BreathingType.peakHold;
            }
            break;
          case BreathingType.peakHold:
            if (_timerCount < 0) {
              _timerCount = _breathOutDuration;
              _breathingType = BreathingType.breathOut;
            }
            break;
          case BreathingType.breathOut:
            _breathingScale -= _breathingOutFraction;
            if (_timerCount < 0) {
              _timerCount = _baseHoldDuration;
              _breathingType = BreathingType.baseHold;
            }
            break;
          case BreathingType.baseHold:
            if (repeats < 0) {
              stop();
            } else {
              if (_timerCount < 0) {
                repeats--;
                _timerCount = _breathInDuration;
                _breathingType = BreathingType.breathIn;
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
