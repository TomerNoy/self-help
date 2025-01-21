import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/services.dart';

part 'collapsing_appbar_provider.g.dart';

enum AppBarType {
  welcome,
  login,
  register,
  home,
  sos,
  hidden,
  loading,
  error,
  gainControl,
  profile,
  settings,
}

@riverpod
class CollapsingAppBar extends _$CollapsingAppBar {
  @override
  AppBarType build() {
    final route = ref.watch(routerListenerProvider);
    final routerProviderWasInit = storageService.readRouterProviderWasInit();

    loggerService
        .debug('CollapsingAppBar: build: $route, $routerProviderWasInit');

    return switch (route) {
      RoutePaths.login =>
        routerProviderWasInit ? AppBarType.login : AppBarType.welcome,
      RoutePaths.register => AppBarType.register,
      RoutePaths.home => AppBarType.home,
      RoutePaths.profile => AppBarType.profile,
      RoutePaths.settings => AppBarType.settings,
      _ => AppBarType.hidden,
    };
  }

  /// Updates the state explicitly, overriding any reactive updates.
  void updateState(AppBarType newState) {
    loggerService.debug('CollapsingAppBar: updateState: $newState');
    state = newState;
  }
}
