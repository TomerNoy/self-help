import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/services/services.dart';
part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  AppUser? build() {
    state = null;

    final subscription = userService.userChanges.listen(
          (user) => state = user,
          onError: (_) => state = null,
        );
    ref.onDispose(() => subscription.cancel());
    return null;
  }
}
