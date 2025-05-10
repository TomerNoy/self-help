import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/services.dart';

part 'user_auth_provider.g.dart';

enum UserAuthState { authenticated, unauthenticated, hasError, loading }

@riverpod
Stream<UserAuthState> userAuth(Ref ref) async* {
  yield UserAuthState.loading;

  yield* userAuthService.authStateChanges.distinct().handleError(
    (error, stackTrace) {
      LoggerService.error("Error in userAuth stream: $error", stackTrace);
      return UserAuthState.hasError;
    },
  );
}
