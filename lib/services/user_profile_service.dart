import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/models/result.dart';
import 'package:self_help/services/services.dart';

class UserProfileService {
  UserProfileService() {
    _userChangesSub = _auth
        .userChanges()
        .map((user) => user == null ? null : AppUser.fromFirebaseUser(user))
        .distinct()
        .listen(_userChanges.add);
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userChanges = BehaviorSubject<AppUser?>();
  late final StreamSubscription<AppUser?> _userChangesSub;
  Stream<AppUser?> get userChanges => _userChanges.stream;

  AppUser get currentUser => AppUser.fromFirebaseUser(_auth.currentUser!);

  Future<Result<String>> updateUserName({required String name}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Result.failure('User not found');
    return _handleCall(() async {
      await user.updateProfile(displayName: name);
      await user.reload();
      loggerService.info('User name updated: ${user.displayName}');
      return 'updated successfully';
    });
  }

  Future<Result<T>> _handleCall<T>(Future<T> Function() operation) async {
    try {
      return Result.success(
        await operation().timeout(
          Constants.defaultTimeout,
          onTimeout: () => throw TimeoutException(
            'The connection has timed out, please try again.',
          ),
        ),
      );
    } on TimeoutException catch (e, st) {
      loggerService.error('Operation timed out', e, st);
      return Result.failure('Operation timed out. Please try again.');
    } on FirebaseException catch (e, st) {
      loggerService.error('Firebase error', e, st);
      return Result.failure(
        e.code.replaceAll('-', ' ').toLowerCase(),
      );
    } catch (e, st) {
      loggerService.error('Unexpected error', e, st);
      return Result.failure('An unexpected error occurred. Please try again.');
    }
  }

  void dispose() {
    _userChangesSub.cancel();
  }
}
