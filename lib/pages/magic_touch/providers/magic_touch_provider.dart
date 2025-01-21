import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/services/services.dart';

part 'magic_touch_provider.g.dart';

@riverpod
class MagicTouch extends _$MagicTouch {
  Timer? _timer;
  bool isFinished = false;

  @override
  int? build() {
    ref.onDispose(
      () {
        loggerService.debug('disposing magic touch notifier');
        _timer?.cancel();
        _timer = null;
      },
    );
    return null;
  }

  void startTimer() {
    if (state != null) return;

    state = 0;

    _timer = Timer.periodic(
      Constants.timerDuration,
      (ticker) {
        if (state == 30) {
          stop();
          isFinished = true;
          return;
        }
        state = ticker.tick;
      },
    );
  }

  void stop() {
    _timer?.cancel();
    state = null;
  }
}
