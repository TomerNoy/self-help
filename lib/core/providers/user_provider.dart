import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/services/services.dart';

final currentUserProvider = StreamProvider<User?>((ref) {
  return userService.authStateChanges();
});
