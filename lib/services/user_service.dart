import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
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
    try {
      _authStateChanges.add(UserAuthState.loading);
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: name);
      //todo add validation
      await userCredential.user!.reload();
      final updatedUser = _auth.currentUser;
      loggerService
          .info('User registered with name: ${updatedUser?.displayName}');

      loggerService.info('User registered ${userCredential.user}');
      return Result.success(updatedUser!);
    } on FirebaseAuthException catch (e) {
      loggerService.error('Registration failed', e);
      switch (e.code) {
        case 'email-already-in-use':
          return Result.failure('Email is already in use.');
        case 'invalid-email':
          return Result.failure('Invalid email address.');
        case 'weak-password':
          return Result.failure('Password is too weak.');
        default:
          return Result.failure('Registration failed. Please try again.');
      }
    } catch (e, st) {
      loggerService.error('Registration failed', e, st);
      return Result.failure('Registration failed. Please try again.');
    }
  }

  Future<Result<User>> loginUser(String email, String password) async {
    _authStateChanges.add(UserAuthState.loading);
    loggerService.info('Logging in user with email: $email');
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loggerService.info('User logged in ${userCredential.user}');
      return Result.success(userCredential.user!);
    } catch (e, st) {
      loggerService.error('Login failed', e, st);
      if (e.toString().contains('credential is incorrect')) {
        return Result.failure('Invalid email or password.');
      }
      return Result.failure('An unexpected error occurred. Please try again.');
    }
  }

  Future<Result<User>> loginWithGoogle(GoogleSignInAccount googleUser) async {
    _authStateChanges.add(UserAuthState.loading);
    try {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      loggerService.info('Google user logged in: ${userCredential.user}');
      return Result.success(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      loggerService.error('Google login failed', e);
      return Result.failure('Google login failed. Please try again.');
    } catch (e, st) {
      loggerService.error('Unexpected error during Google login', e, st);
      return Result.failure('An unexpected error occurred. Please try again.');
    }
  }

  Future<void> signOut() async {
    _authStateChanges.add(UserAuthState.loading);
    await _auth.signOut();
  }

  Future<Result<String>> updateUserName({required String name}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Result.failure('User not found');

      await user.updateProfile(displayName: name);
      await user.reload();
      loggerService.info('User name updated: ${user.displayName}');
      return Result.success('updated successfully');
    } catch (e) {
      loggerService.error('Failed to update user name: $e');
      return Result.failure('Failed to update user');
    }
  }

  void dispose() {
    _userChangesSub.cancel();
    _authChangesSub.cancel();
  }
}
