import 'package:flutter/material.dart';
import 'package:self_help/services/services.dart';

class AppLifeCycleService extends WidgetsBindingObserver {
  AppLifeCycleService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    loggerService.debug('app state: ${state.name}');

    if (state == AppLifecycleState.resumed) {
      //todo
    } else {
      //todo
    }
  }
}
