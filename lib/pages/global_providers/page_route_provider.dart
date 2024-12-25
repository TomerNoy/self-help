import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/services/services.dart';

final pageRouteProvider = Provider((ref) => FlowController());

enum FlowType { sos, gainControll }

class FlowController extends StateNotifier<int> {
  FlowController() : super(0);

  final List<String> sosFlow = [
    RouteNames.sosLanding,
    RouteNames.stressLevel,
    RouteNames.enterNumber,
    RouteNames.enterNumberReversed,
    RouteNames.breathing,
    RouteNames.stressLevel,
    RouteNames.calculateExercise,
    RouteNames.lookAroundExercise,
    RouteNames.stressLevel,
    RouteNames.gainControllLanding,
    RouteNames.thoughtRelease,
  ];

  final List<String> gainControll = [
    RouteNames.gainControllLanding,
    RouteNames.lookAroundExercise,
    RouteNames.calculateExercise,
    RouteNames.stressLevel,
    RouteNames.enterNumber,
    RouteNames.enterNumberReversed,
    RouteNames.stressLevel,
    RouteNames.breathing,
    RouteNames.stressLevel,
  ];

  late List<String> currentFlow;

  void startFlow(FlowType flow, BuildContext context) {
    switch (flow) {
      case FlowType.sos:
        currentFlow = sosFlow;
        break;
      case FlowType.gainControll:
        currentFlow = gainControll;
        break;
    }
    state = 0;
    context.pushNamed(currentFlow[state]);
  }

  bool get isLast => state == currentFlow.length - 1;

  String get currentRoute => currentFlow[state];

  int get currentState => state;

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
      context.goNamed(RouteNames.home);
    }
  }

  void backNoPop() => state--;

  void goToHome(BuildContext context) {
    loggerService.debug('Ending flow, resetting state to 0');
    state = 0;
    context.goNamed(RouteNames.home);
  }
}
