import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/services.dart';

part 'page_flow_provider.g.dart';

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
    loggerService.debug(
        'flow state changing to: ${index ?? this.index}, ${flowType ?? this.flowType}');
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
    // default state
    return const PageFlowState(
      index: 0,
      flowType: FlowType.none,
    );
  }

  List<String> get _currentFlowList => FlowLists.flowListsMap[state.flowType]!;

  // init flow by type
  void startFlow(FlowType flowType) {
    loggerService.debug('flow state started for $flowType');
    final router = ref.read(routerStateProvider);
    final routeToGo = FlowLists.flowListsMap[flowType]!.first;
    router.pushNamed(routeToGo);
    state = PageFlowState(
      flowType: flowType,
      index: 0,
    );
  }

  // next with router control
  void next([
    Map<String, String> params = const {},
  ]) {
    if (_currentFlowList.length > state.index + 1) {
      state = state.copyWith(index: state.index + 1);
      loggerService.debug('flow state changed to: $state');
      final router = ref.read(routerStateProvider);
      final routeToGo = _currentFlowList[state.index];
      loggerService.debug('routeToGo: $routeToGo');
      router.pushNamed(routeToGo, pathParameters: params);
    }
  }

  // back with router control
  void back() {
    final router = ref.read(routerStateProvider);
    if (state.index > 0) {
      state = state.copyWith(index: state.index - 1);
      final routeToGo = _currentFlowList[state.index];
      router.pushNamed(routeToGo);
      loggerService.debug('flow state changed to: $state');
    } else {
      backToHome();
    }

    loggerService.debug('flow state changed to: $state');
  }

  // back without router control
  void didPop() {
    // if index is 0, then back to home is
    // handled by resetFlowIfNeeded - triggered by RouterListenerProvider
    if (state.index > 0) {
      state = state.copyWith(index: state.index - 1);
      loggerService.debug('flow state changed to: $state');
    }
  }

  // back to home
  void backToHome() {
    loggerService.debug('Ending flow state, resetting state to 0');
    final router = ref.read(routerStateProvider);
    router.goNamed(RoutePaths.home.name);
    _reset();

    // todo dispose this provider
  }

  // internal reset
  void _reset() {
    state = const PageFlowState(
      index: 0,
      flowType: FlowType.none,
    );
  }

  // reset flow in case user exits flow
  void resetFlowIfNeeded(RoutePaths path) {
    loggerService.debug(
      'updatePageIndex with path: $path, current state: $state',
    );

    if (!_currentFlowList.contains(path.name)) {
      _reset();
    }
  }
}
