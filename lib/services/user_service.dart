import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/models/result.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/services/services.dart';

class UserService {
  UserService() {
    _authStateChanges.add(UserAuthState.loading);
    _authChangesSub = _auth
        .authStateChanges()
        .map((user) => user == null
            ? UserAuthState.unauthenticated
            : UserAuthState.authenticated)
        .distinct()
        .listen(_authStateChanges.add);

    _userChangesSub = _auth
        .userChanges()
        .map((user) => user == null ? null : AppUser.fromFirebaseUser(user))
        .distinct()
        .listen(_userChanges.add);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _userChanges = BehaviorSubject<AppUser?>();
  final _authStateChanges = BehaviorSubject<UserAuthState>();

  late final StreamSubscription<AppUser?> _userChangesSub;
  late final StreamSubscription<UserAuthState> _authChangesSub;

  Stream<AppUser?> get userChanges => _userChanges.stream;
  Stream<UserAuthState> get authStateChanges => _authStateChanges.stream;

  AppUser get currentUser => AppUser.fromFirebaseUser(_auth.currentUser!);

  Future<Result<User>> registerUser(
    String email,
    String password,
    String name,
  ) async {
    return _handleCall(() async {
      _authStateChanges.add(UserAuthState.loading);
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: name);
      await userCredential.user!.reload();
      final updatedUser = _auth.currentUser;
      loggerService.info('User registered: ${updatedUser?.displayName}');
      return updatedUser!;
    });
  }

  Future<Result<User>> loginUser(String email, String password) async {
    return _handleCall(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loggerService.info('User logged in: ${userCredential.user}');
      return userCredential.user!;
    });
  }

  Future<Result<User>> loginWithGoogle(GoogleSignInAccount googleUser) async {
    return _handleCall(() async {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      loggerService.info('User logged in with Google: ${userCredential.user}');
      return userCredential.user!;
    });
  }

  Future<Result<void>> signOut() async {
    return _handleCall(() async {
      await _auth.signOut();
      loggerService.info('User signed out');
    });
  }

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
    _authStateChanges.add(UserAuthState.loading);
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
    _authChangesSub.cancel();
  }
}
