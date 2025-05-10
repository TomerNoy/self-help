import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/models/page_flow_state.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/logger_service.dart';

part 'page_flow_provider.g.dart';

enum StressType { low, medium, high }

@Riverpod(keepAlive: true)
class PageFlow extends _$PageFlow {
  @override
  PageFlowState build() {
    // default state
    return const PageFlowState(
      index: 0,
      flowList: [],
    );
  }

  void startFlow() {
    // update state
    state = PageFlowState(
      index: 0,
      flowList: initCheckStress,
    );
    // go to page
    _goToPage();
  }

  void _goToPage() {
    final router = ref.read(routerStateProvider);
    final routeName = state.flowList[state.index].name;
    try {
      router.pushNamed(routeName);
    } catch (e) {
      LoggerService.error('Failed to navigate to $routeName: $e');
      _backToHome();
    }
  }

  void next([StressType? stressType]) {
    LoggerService.debug(
      'updatePageIndex with stressType: $stressType, current state: $state',
    );

    if (state.flowList.isEmpty) {
      LoggerService.debug('Flow list is empty, cannot proceed');

      throw Exception(
        'Flow list is empty, cannot proceed',
      );
    }

    if (state.flowList.length > state.index + 1) {
      // update state
      state = state.copyWith(index: state.index + 1);
      // go to page
      _goToPage();
    } else if (state.flowList.length == 1) {
      state = state.copyWith(
        index: state.index + 1,
        flowList: [...state.flowList, ...beginSosRoutes],
      );
      _goToPage();
    } else if (stressType == null) {
      throw Exception(
        'StressType is null on end flow',
      );
    } else if (stressType == StressType.low) {
      _backToHome();
    } else {
      final lastRoute = _getLastRoute();
      if (lastRoute == null) return;
      // update state
      state = state.copyWithAddReplaceRoutes(
        stressType == StressType.medium
            ? _getNextMediumStressRoutes(lastRoute)
            : _getNextHighStressRoutes(lastRoute),
      );
      _goToPage();
    }
  }

  RoutePaths? _getLastRoute() {
    if (state.flowList.length < 2) return null;
    return state.flowList[state.flowList.length - 2];
  }

  List<RoutePaths> _getNextMediumStressRoutes(RoutePaths lastRoute) {
    if (beginSosRoutes.contains(lastRoute)) {
      return thoughtRoutes;
    } else if (thoughtRoutes.contains(lastRoute)) {
      return questionRoutes;
    } else if (relaxRoutes.contains(lastRoute)) {
      return thoughtRoutes;
    } else if (questionRoutes.contains(lastRoute)) {
      return endSosRoutes;
    } else if (endSosRoutes.contains(lastRoute)) {
      return thoughtRoutes;
    } else {
      return [];
    }
  }

  List<RoutePaths> _getNextHighStressRoutes(RoutePaths lastRoute) {
    if (beginSosRoutes.contains(lastRoute)) {
      return relaxRoutes;
    } else if (thoughtRoutes.contains(lastRoute)) {
      return relaxRoutes;
    } else if (relaxRoutes.contains(lastRoute)) {
      return beginSosRoutes;
    } else if (questionRoutes.contains(lastRoute)) {
      return thoughtRoutes;
    } else if (endSosRoutes.contains(lastRoute)) {
      return relaxRoutes;
    } else {
      return [];
    }
  }

  // back with router control
  void updateBack() {
    // update to default state
    if (state.index < 1) {
      // _reset();
    } else {
      final backPage = state.flowList[state.index - 1];
      final isBackStressLevel = backPage == RoutePaths.stressLevel;
      final shouldCleanRoutes = state.index > 1 && isBackStressLevel;

      LoggerService.debug(
        'shouldCleanRoutes: $shouldCleanRoutes, isBackStressLevel : $isBackStressLevel',
      );

      final flowList = shouldCleanRoutes
          ? state.flowList.sublist(0, state.index - 1)
          : state.flowList;

      // update state
      state = state.copyWith(
        index: state.index - 1,
        flowList: flowList,
      );
    }
  }

  // back to home
  void _backToHome() {
    final router = ref.read(routerStateProvider);
    router.goNamed(RoutePaths.home.name);
    _reset();
    LoggerService.debug(
      'back to home with state: $state',
    );

    // TODO: dispose this provider?
  }

  // internal reset
  void _reset() {
    state = const PageFlowState(
      index: 0,
      flowList: [],
    );
  }

  // reset flow in case user exits flow
  void resetFlowIfNeeded(RoutePaths path) {
    LoggerService.debug(
      'updatePageIndex with path: $path, current state: $state',
    );

    if (!state.flowList.contains(path)) {
      _reset();
    }
  }
}
