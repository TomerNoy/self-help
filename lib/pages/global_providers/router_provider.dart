import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/pages/global_providers/overlay_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/services/services.dart';

final routerProvider = Provider((ref) {
  final pageOverlayProvider = ref.watch(pageOverlayStateProvider);
  loggerService.info('pageOverlayProvider: $pageOverlayProvider');

  return router(redirect: (context, state) {
    final authState = ref.watch(userAuthStateProvider);

    if (authState.isLoading || authState.hasError) return null;

    final isAuthenticated = authState.valueOrNull != null;
    final isAuthenticating = state.matchedLocation == RoutPaths.login;

    if (!isAuthenticated && state.matchedLocation == RoutPaths.register) {
      return null;
    }

    if (!isAuthenticated) {
      return RoutPaths.login;
    }

    if (isAuthenticating) {
      return RoutPaths.home;
    }

    if (isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ref.read(collapsingAppBarProvider.notifier).state =
              AppBarState.hidden;
        },
      );
    }

    return null;
  });
});
