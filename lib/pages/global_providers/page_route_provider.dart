import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/services/services.dart';

final pageRouteProvider = Provider((ref) => FlowController());

enum FlowType { flow1, flow2, sos }

class FlowController extends StateNotifier<int> {
  FlowController() : super(0);

  final List<String> flow1 = [
    RouteNames.stressLevel,
    RouteNames.breathing,
    RouteNames.stressLevel,
    RouteNames.butterfly,
    RouteNames.stressLevel,
  ];

  final List<String> flow2 = [
    RouteNames.stressLevel,
    RouteNames.butterfly,
    RouteNames.stressLevel,
    RouteNames.breathing,
    RouteNames.stressLevel,
  ];

  final List<String> sosFlow = [
    RouteNames.sosLanding,
    RouteNames.calculateExercise,
    RouteNames.stressLevel,
    RouteNames.enterNumber,
    RouteNames.enterNumberReversed,
    RouteNames.stressLevel,
    RouteNames.breathing,
    RouteNames.stressLevel,
  ];

  late List<String> currentFlow;

  void startFlow(FlowType flow) {
    switch (flow) {
      case FlowType.flow1:
        currentFlow = flow1;
        break;
      case FlowType.flow2:
        currentFlow = flow2;
        break;
      case FlowType.sos:
        currentFlow = sosFlow;
        break;
    }
    state = 0;
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
      context.pushNamed(
        currentFlow[state],
        pathParameters: params,
      );
      loggerService.debug('push to state: $state');
    }
  }

  void back(BuildContext context) {
    loggerService.debug('state: $state');
    if (state > 0) {
      state--;
      context.pop();
    }
  }

  void backNoPop() => state--;

  void goToHome(BuildContext context) {
    loggerService.debug('Ending flow, resetting state to 0');
    state = 0;
    context.goNamed(RouteNames.home);
  }
}
