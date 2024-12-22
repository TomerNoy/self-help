import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/services/services.dart';

final userAuthStateProvider = StreamProvider<User?>((ref) {
  return userService.authStateChanges();
});

final userStateProvider = StreamProvider<AppUser?>((ref) {
  return userService.userStateChanges;
});
