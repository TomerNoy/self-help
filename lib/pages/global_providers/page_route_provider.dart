import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/core/routes_constants.dart';
import 'package:self_help/services/services.dart';

part 'page_route_provider.g.dart';

enum FlowType { sos, gainControl }

@Riverpod(keepAlive: true)
class PageFlow extends _$PageFlow {
  final List<String> sosFlow = [
    RoutNames.home,
    RoutNames.stressLevel,
    RoutNames.enterNumber,
    RoutNames.enterNumberReversed,
    RoutNames.breathing,
    RoutNames.stressLevel,
    RoutNames.calculateExercise,
    RoutNames.lookAroundExercise,
    RoutNames.stressLevel,
    RoutNames.gainControlLanding,
    RoutNames.thoughtRelease,
  ];

  final List<String> gainControl = [
    RoutNames.gainControlLanding,
    RoutNames.lookAroundExercise,
    RoutNames.calculateExercise,
    RoutNames.stressLevel,
    RoutNames.enterNumber,
    RoutNames.enterNumberReversed,
    RoutNames.stressLevel,
    RoutNames.breathing,
    RoutNames.stressLevel,
  ];

  late List<String> currentFlow;

  bool get isLast => state == currentFlow.length - 1;

  String get currentRoute => currentFlow[state];

  int get currentState => state;

  @override
  int build() {
    return 0;
  }

  void startFlow(FlowType flow, BuildContext context) {
    switch (flow) {
      case FlowType.sos:
        currentFlow = sosFlow;
        break;
      case FlowType.gainControl:
        currentFlow = gainControl;
        break;
    }
    state = 1;
    loggerService.debug(
      'Starting flow: $flow with state: $state, route: ${currentFlow[state]}',
    );
    context.pushNamed(currentFlow[state]);
  }

  void next(
    BuildContext context, [
    Map<String, String> params = const {},
  ]) {
    loggerService
        .debug('state: $state, currentFlow.length: ${currentFlow.length}');

    if (state < currentFlow.length - 1) {
      state++;
      context.pushNamed(currentFlow[state], pathParameters: params);
      loggerService.debug('push to state: $state');
    }
  }

  void back(BuildContext context) {
    loggerService.debug('state: $state');
    if (state > 0) {
      state--;
      context.pop();
    } else {
      context.goNamed(RoutNames.home);
    }
  }

  void backNoPop() => state--;

  void goToHome(BuildContext context) {
    loggerService.debug('Ending flow, resetting state to 0');
    state = 0;
    context.goNamed(RoutNames.home);
  }
}
