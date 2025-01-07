import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/flow_route_constant.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/core/routes_constants.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/services.dart';

part 'page_route_provider.g.dart';

@immutable
class PageFlowState {
  final int index;
  final FlowType flowType;

  const PageFlowState({
    required this.index,
    required this.flowType,
  });

  PageFlowState copyWith({
    int? index,
    FlowType? flowType,
  }) {
    return PageFlowState(
      index: index ?? this.index,
      flowType: flowType ?? this.flowType,
    );
  }

  @override
  String toString() {
    return 'PageFlowState{index: $index, flowType: $flowType}';
  }
}

@Riverpod(keepAlive: true)
class PageFlow extends _$PageFlow {
  @override
  PageFlowState build() {
    return const PageFlowState(
      index: 0,
      flowType: FlowType.none,
    );
  }

  void startFlow(FlowType flowType) {
    final router = ref.read(routerStateProvider);
    final routeToGo = FlowLists.flowListsMap[flowType]!.first;
    router.pushNamed(routeToGo);
    state = PageFlowState(
      flowType: flowType,
      index: 0,
    );
    loggerService.debug('flow state started for $flowType');
  }

  void next([
    Map<String, String> params = const {},
  ]) {
    if (FlowLists.flowListsMap[state.flowType]!.length > state.index + 1) {
      state = state.copyWith(index: state.index + 1);
      final router = ref.read(routerStateProvider);
      final routeToGo = FlowLists.flowListsMap[state.flowType]![state.index];
      router.pushNamed(routeToGo, pathParameters: params);
      loggerService.debug('flow state changed to: $state');
    }
  }

  void back() {
    final router = ref.read(routerStateProvider);
    if (state.index > 0) {
      state = state.copyWith(index: state.index - 1);
      final routeToGo = FlowLists.flowListsMap[state.flowType]![state.index];
      router.pushNamed(routeToGo);
      loggerService.debug('flow state changed to: $state');
    } else {
      resetBackToHome();
    }

    loggerService.debug('flow state changed to: $state');
  }

  void backNoPop() {
    if (state.index > 0) {
      state = state.copyWith(index: state.index - 1);
    } else if (state.index == 0) {
      resetBackToHome();
    }
  }

  void resetBackToHome() {
    loggerService.debug('Ending flow state, resetting state to 0');
    final router = ref.read(routerStateProvider);
    router.goNamed(RoutNames.home);
    state = const PageFlowState(
      index: 0,
      flowType: FlowType.none,
    );

    // todo dispose this provider
  }
}
