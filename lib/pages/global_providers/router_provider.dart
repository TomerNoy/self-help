import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/page_route_provider.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/services/services.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter routerState(Ref ref) {
  // final authProvider = ref.watch(userAuthProvider);

  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  var authState = ValueNotifier<UserAuthState>(UserAuthState.loading);

  authState.addListener(() {
    loggerService.debug('§ authState listener triggered: ${authState.value}');
  });

  ref
    ..onDispose(() {
      loggerService.info('§ RouterProvider: disposed');
      authState.dispose();
    })
    ..listen<AsyncValue<UserAuthState>>(
      userAuthProvider,
      (previous, next) {
        loggerService.debug('§ userAuthProvider next: $next');
        if (next.hasValue) {
          authState.value = next.value!;
          loggerService.debug('§ authState updated to: ${authState.value}');
        }
      },
    );

  final appRouter = router(
    refreshListenable: authState,
    routerKey: routerKey,
    redirect: (context, state) async {
      final location = state.matchedLocation;

      final isOnRestrictedPage = location != RoutePaths.login.path &&
          location != RoutePaths.register.path;

      final isLoadingRoute = location == RoutePaths.loading.path;

      final shouldRedirectToLogin = isOnRestrictedPage || isLoadingRoute;
      final shouldRedirectToHome = !isOnRestrictedPage || isLoadingRoute;

      loggerService.debug('§ authState: ${authState.value}');

      return switch (authState.value) {
        UserAuthState.authenticated =>
          shouldRedirectToHome ? RoutePaths.home.path : null,
        UserAuthState.unauthenticated =>
          shouldRedirectToLogin ? RoutePaths.login.path : null,
        UserAuthState.hasError => null,
        UserAuthState.loading =>
          isLoadingRoute ? null : RoutePaths.loading.path,
      };
    },
  );

  appRouter.routerDelegate.addListener(
    () {
      final newRoute =
          appRouter.routerDelegate.currentConfiguration.lastOrNull?.route.path;

      loggerService.info('§ RouterProvider: route changed to $newRoute');

      if (newRoute == null) {
        loggerService.warning('§ Route changed to null');
      }

      final path = RoutePaths.fromPath(newRoute!);

      if (path != null) {
        ref.read(routerListenerProvider.notifier).updateState(path);
      }
    },
  );

  ref.onDispose(
    () {
      loggerService.info('§ RouterProvider: disposed');
      appRouter.dispose();
    },
  );
  return appRouter;
}

@Riverpod(keepAlive: true)
class RouterListener extends _$RouterListener {
  @override
  RoutePaths build() {
    return RoutePaths.loading;
  }

  void updateState(RoutePaths newState) {
    if (newState == state) return;
    ref.read(pageFlowProvider.notifier).updatePageIndex(newState);
    state = newState;
  }
}
