import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/models/result.dart';
import 'package:self_help/services/services.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser get currentUser => AppUser.fromFirebaseUser(_auth.currentUser!);

  Stream<AppUser?> get userStateChanges {
    return _auth.userChanges().map(
      (user) {
        return user == null ? null : AppUser.fromFirebaseUser(user);
      },
    );
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<Result<User>> registerUser(
      String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: name);
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
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loggerService.info('User logged in ${userCredential.user}');
      return Result.success(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      loggerService.error('Login failed', e);
      switch (e.code) {
        case 'user-not-found':
          return Result.failure('No user found for this email.');
        case 'wrong-password':
          return Result.failure('Incorrect password.');
        default:
          return Result.failure('Login failed. Please try again.');
      }
    } catch (e, st) {
      loggerService.error('Login failed', e, st);
      return Result.failure('An unexpected error occurred. Please try again.');
    }
  }

  Future<Result<User>> loginWithGoogle(GoogleSignInAccount googleUser) async {
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
    await _auth.signOut();
  }
}
