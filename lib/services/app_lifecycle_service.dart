import 'package:flutter/material.dart';
import 'package:self_help/services/logger_service.dart';

class AppLifeCycleService extends WidgetsBindingObserver {
  AppLifeCycleService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    LoggerService.debug('app state: ${state.name}');

    if (state == AppLifecycleState.resumed) {
      //TODO:
    } else {
      //TODO:
    }
  }
}
