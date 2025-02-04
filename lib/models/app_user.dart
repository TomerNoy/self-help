import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser extends Equatable {
  final String uid;
  final String email;
  final String? displayName;

  const AppUser({
    required this.uid,
    required this.email,
    this.displayName,
  });

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName,
    );
  }

  @override
  List<Object> get props => [uid, email, displayName ?? ''];
}
