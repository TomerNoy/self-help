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
  final appRouter = router(
    redirect: (context, state) async {
      final location = state.matchedLocation;

      final isOnRestrictedPage =
          location != RoutPaths.login && location != RoutPaths.register;

      final authProvider = ref.watch(userAuthProvider);
      return await authProvider.when(
        data: (data) {
          loggerService
              .debug('§ userAuthStream data: $data, location: $location');

          if (data == UserAuthState.authenticated) {
            if (!isOnRestrictedPage) {
              loggerService.debug('§ Redirecting to home');
              return RoutPaths.home;
            }
          } else {
            if (isOnRestrictedPage) {
              loggerService.debug('§ Redirecting to login');
              return RoutPaths.login;
            }
          }
          return null;
        },
        error: (error, stackTrace) {
          loggerService.error('§ userAuthStream error: $error', stackTrace);
          return null;
        },
        loading: () {
          loggerService.debug('§ userAuthStream loading');
          return null;
        },
      );
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
    return RoutPaths.login;
  }

  void updateState(String newState) {
    if (newState == state) return;
    state = newState;
  }
}
