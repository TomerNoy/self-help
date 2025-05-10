import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:retry/retry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:self_help/core/constants/constants.dart';
// import 'package:self_help/models/app_user.dart';
import 'package:self_help/models/result.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:self_help/services/logger_service.dart';

/// this class is responsible for handling user authentication and user data
class UserAuthService {
  UserAuthService() {
    _authStateChanges.add(UserAuthState.loading);
    _authChangesSub = _auth
        .authStateChanges()
        .map((user) => user == null
            ? UserAuthState.unauthenticated
            : UserAuthState.authenticated)
        .distinct()
        .listen(_authStateChanges.add);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authStateChanges = BehaviorSubject<UserAuthState>();
  late final StreamSubscription<UserAuthState> _authChangesSub;

  Stream<UserAuthState> get authStateChanges => _authStateChanges.stream;

  /// this method is used to register a new user
  Future<Result<User>> registerUser(
    String email,
    String password,
    String name,
  ) async {
    // this method is used to handle the call to the firebase authentication
    return _handleCall(() async {
      _authStateChanges.add(UserAuthState.loading);
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      try {
        await userCredential.user!.updateProfile(displayName: name);
        await userCredential.user!.reload();
      } catch (e, st) {
        LoggerService.error('Error updating user profile', e, st);
        return Future.error(
          'Error updating user profile. Please try again.',
        );
      }
      final updatedUser = _auth.currentUser;
      LoggerService.info('User registered: ${updatedUser?.displayName}');
      return updatedUser!;
    });
  }

  Future<Result<User>> loginUser(String email, String password) async {
    return _handleCall(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoggerService.info('User logged in: ${userCredential.user}');
      return userCredential.user!;
    });
  }

  Future<Result<User>> loginWithGoogle(GoogleSignInAccount googleUser) async {
    return _handleCall(() async {
      try {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        LoggerService
            .info('User logged in with Google: ${userCredential.user}');
        return userCredential.user!;
      } on PlatformException catch (e) {
        if (e.code == 'sign_in_canceled') {
          LoggerService.info('Google Sign-In canceled');
          return Future.error(
            'Google Sign-In canceled. Please try again.',
          );
        }
        rethrow;
      }
    });
  }

  Future<Result<void>> signOut() async {
    return _handleCall(() async {
      await _auth.signOut();
      LoggerService.info('User signed out');
    });
  }

  Future<Result<T>> _handleCall<T>(Future<T> Function() operation) async {
    _authStateChanges.add(UserAuthState.loading);
    try {
      final result = await _retryOperation(operation);

      if (result == null) {
        LoggerService.error(
            'Operation returned null', null, StackTrace.current);
        _authStateChanges.add(UserAuthState.hasError);
        return Result.failure('Operation failed. Please try again.');
      }
      LoggerService.info('Operation successful: $result');
      return Result.success(result);
    } on TimeoutException catch (e, st) {
      LoggerService.error('Operation timed out', e, st);

      _authStateChanges.add(UserAuthState.hasError);

      return Result.failure('Operation timed out. Please try again.');
    } on FirebaseException catch (e, st) {
      LoggerService.error('Firebase error', e, st);

      _authStateChanges.add(
          ['user-not-found', 'wrong-password', 'user-disabled'].contains(e.code)
              ? UserAuthState.unauthenticated
              : UserAuthState.hasError);

      return Result.failure(
        _firebaseErrorMessages[e.code] ??
            'Authentication failed. Please try again.',
      );
    } catch (e, st) {
      LoggerService.error('Unexpected error', e, st);
      _authStateChanges.add(UserAuthState.hasError);
      return Result.failure('An unexpected error occurred. Please try again.');
    }
  }

  Future<T?> _retryOperation<T>(Future<T?> Function() operation) async {
    return retry(
      () => operation().timeout(
        Constants.defaultTimeout,
        onTimeout: () => throw TimeoutException('Authentication timed out'),
      ),
      maxAttempts: 3,
      delayFactor: Duration(seconds: 1),
      randomizationFactor: 0.25,
    );
  }

  static const _firebaseErrorMessages = {
    'user-not-found': 'User not found. Please register.',
    'wrong-password': 'Wrong password. Please try again.',
    'email-already-in-use': 'Email already in use. Please try another.',
    'invalid-email': 'Invalid email. Please try again.',
    'operation-not-allowed': 'Operation not allowed. Please try again.',
    'weak-password': 'Weak password. Please try again.',
    'network-request-failed': 'Network request failed. Please try again.',
    'user-disabled': 'User disabled. Please contact support.',
    'invalid-credential': 'Invalid credentials. Please check and try again.',
    'account-exists-with-different-credential':
        'Account exists with a different sign-in method. Try another provider.',
    'too-many-requests': 'Too many attempts. Please try again later.',
    'requires-recent-login': 'Please sign in again to perform this action.',
  };

  void dispose() {
    _authChangesSub.cancel();
  }
}
