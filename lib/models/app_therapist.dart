import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './app_user.dart';
import './contact_details.dart';

enum Gender {
  male,
  female,
  other,
}

class AppTherapist extends AppUser
{
  final String? imagePath;
  final String description;
  final Gender gender;
  final ContactDetails contactDetails;

  const AppTherapist({
    required uid,
    required email,
    String? displayName,
    this.imagePath,
    required this.description,
    required this.gender,
    required this.contactDetails,
  }) : super(uid: uid, email: email, displayName: displayName );

  factory AppTherapist.fromFirebaseUser({
    required User user,
    String? imagePath,
    required String description,
    required Gender gender,
    required ContactDetails contactDetails,
  }) {
    return AppTherapist(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName,
      imagePath: imagePath,
      description: description,
      gender: gender,
      contactDetails: contactDetails,
    );
  }

  @override
  List<Object> get props => [uid, email, displayName ?? '',
    imagePath ?? "", gender, description, contactDetails];
}