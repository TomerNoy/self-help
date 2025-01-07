import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/core/routes_constants.dart';
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

      final isOnRestrictedPage =
          location != RoutPaths.login && location != RoutPaths.register;

      final isLoadingRoute = location == RoutPaths.loading;

      final shouldRedirectToLogin = isOnRestrictedPage || isLoadingRoute;
      final shouldRedirectToHome = !isOnRestrictedPage || isLoadingRoute;

      loggerService.debug('§ authState: ${authState.value}');

      return switch (authState.value) {
        UserAuthState.authenticated =>
          shouldRedirectToHome ? RoutPaths.home : null,
        UserAuthState.unauthenticated =>
          shouldRedirectToLogin ? RoutPaths.login : null,
        UserAuthState.hasError => null,
        UserAuthState.loading => isLoadingRoute ? null : RoutPaths.loading,
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

      ref.read(routerListenerProvider.notifier).updateState(newRoute!);
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
  String build() {
    return RoutPaths.loading;
  }

  void updateState(String newState) {
    if (newState == state) return;
    state = newState;
  }
}
