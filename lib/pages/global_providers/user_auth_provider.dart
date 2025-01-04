import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/services/services.dart';

part 'user_auth_provider.g.dart';

enum UserAuthState { authenticated, unauthenticated, hasError }

@riverpod
Stream<UserAuthState> userAuth(Ref ref) async* {
  yield* userService.authStateChanges
      .map<UserAuthState>(
        (user) {
          if (user == null) {
            return UserAuthState.unauthenticated;
          } else {
            return UserAuthState.authenticated;
          }
        },
      )
      .distinct()
      .handleError((error, stackTrace) {
        loggerService.error("Error in userAuth stream: $error", stackTrace);
        return UserAuthState.hasError;
      });
}
