import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/services.dart';

part 'user_provider.g.dart';

@riverpod
Stream<AppUser?> user(Ref ref) async* {
  yield* userProfileService.userChanges
      .map<AppUser?>((user) => user)
      .distinct()
      .handleError(
    (error, stackTrace) {
      LoggerService.error("Error in user stream: $error", stackTrace);
      return null;
    },
  );
}
