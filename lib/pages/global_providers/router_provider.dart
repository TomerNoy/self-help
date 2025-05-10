import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/services/logger_service.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter routerState(Ref ref) {
  var authState = ValueNotifier<UserAuthState>(UserAuthState.loading);

  var hasSeenWelcome = false;

  ref
    ..onDispose(() {
      LoggerService.info('RouterProvider: disposed');
      authState.dispose();
    })
    ..listen<AsyncValue<UserAuthState>>(
      userAuthProvider,
      (previous, next) {
        if (next.hasValue) {
          authState.value = next.value!;
          LoggerService.debug('authState updated to: ${authState.value}');
        }
      },
    );

  final appRouter = router(
    authState: authState,
    updateFlowBack: () => ref.read(pageFlowProvider.notifier).updateBack(),
    redirect: (context, state) async {
      final location = state.matchedLocation;

      final unrestrictedRoutes = [
        RoutePaths.welcome.path,
        RoutePaths.login.path,
        RoutePaths.register.path,
      ];

      final authValue = authState.value;

      final onUnrestrictedPage = unrestrictedRoutes.contains(location);

      LoggerService.debug('authState: $authValue, location: $location');

      // authenticated
      if (authValue == UserAuthState.authenticated) {
        hasSeenWelcome = true;
        if (onUnrestrictedPage) {
          return RoutePaths.home.path;
        }
        return null;
      }

      // unauthenticated
      if (authValue == UserAuthState.unauthenticated) {
        // on restricted page
        if (!onUnrestrictedPage) {
          if (hasSeenWelcome) {
            return RoutePaths.login.path;
          } else {
            hasSeenWelcome = true;
            return RoutePaths.welcome.path;
          }
        }
        return null;
      }
      return null;
    },
  );

  appRouter.routerDelegate.addListener(
    () {
      final newRoute =
          appRouter.routerDelegate.currentConfiguration.lastOrNull?.route.path;

      LoggerService.info('RouterProvider: route changed to $newRoute');

      if (newRoute == null) {
        LoggerService.warning('Route changed to null');
      }

      final path = RoutePaths.fromPath(newRoute!);

      if (path != null) {
        ref.read(routerListenerProvider.notifier).updateState(path);
      }
    },
  );

  ref.onDispose(
    () {
      LoggerService.info('RouterProvider: disposed');
      appRouter.dispose();
    },
  );
  return appRouter;
}

@Riverpod(keepAlive: true)
class RouterListener extends _$RouterListener {
  @override
  RoutePaths build() {
    return RoutePaths.home;
  }

  void updateState(RoutePaths newState) {
    if (newState == state) return;

    state = newState;

    // update flow if needed
    if (ref.read(pageFlowProvider).flowList.isEmpty) return;
    ref.read(pageFlowProvider.notifier).resetFlowIfNeeded(newState);
  }
}
