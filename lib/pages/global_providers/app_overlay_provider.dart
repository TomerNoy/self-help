import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/services/services.dart';

part 'app_overlay_provider.g.dart';

enum AppOverlayType {
  loading,
  error,
  hidden,
}

@immutable
class AppOverlayState {
  final AppOverlayType type;
  final String message;

  const AppOverlayState({
    required this.type,
    this.message = '',
  });

  AppOverlayState copyWith({
    AppOverlayType? type,
    String? message,
  }) {
    return AppOverlayState(
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'AppOverlayState(type: $type, message: $message)';
  }
}

@riverpod
class AppOverlay extends _$AppOverlay {
  @override
  AppOverlayState build() {
    final authProvider = ref.watch(userAuthProvider);
    loggerService.debug('§§ auth state => ${authProvider.value}');
    // loggerService.debug('§§ app overlay state => $state');

    return switch (authProvider.value) {
      UserAuthState.hasError => AppOverlayState(
          type: AppOverlayType.error,
          message: 'Authentication error occurred.\nPlease try again.',
        ),
      UserAuthState.loading => AppOverlayState(
          type: AppOverlayType.loading,
          message: 'Loading...',
        ),
      _ => AppOverlayState(
          type: AppOverlayType.hidden,
          message: '',
        ),
    };
  }

  void updateState(AppOverlayState newState) {
    state = state.copyWith(
      type: newState.type,
      message: newState.message,
    );
  }
}
