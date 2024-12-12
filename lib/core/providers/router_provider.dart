import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/providers/overlay_provider.dart';
import 'package:self_help/core/providers/user_provider.dart';
import 'package:self_help/routes/router.dart';
import 'package:self_help/services/services.dart';

final routerProvider = Provider((ref) {
  final pageOverlayProvider = ref.watch(pageOverlayStateProvider);

  return router(redirect: (context, state) {
    final authState = ref.watch(currentUserProvider);

    // Display the loading overlay
    if (authState.isLoading) {
      // loadingOverlay.show(context); // Show loading overlay
      return null; // Prevent navigation
    } else {
      // loadingOverlay.hide(); // Hide loading overlay when done
    }

    loggerService.info('Auth state: $authState');

    if (authState.isLoading || authState.hasError) return null;

    final isAuthenticated = authState.valueOrNull != null;
    final isAuthenticating = state.matchedLocation == RoutPaths.welcome;

    if (!isAuthenticated && state.matchedLocation == RoutPaths.register) {
      return null;
    }

    if (!isAuthenticated) {
      return RoutPaths.welcome;
    }

    if (isAuthenticating) {
      return RoutPaths.home;
    }

    return null;
  });
});
