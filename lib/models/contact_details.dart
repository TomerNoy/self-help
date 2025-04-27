import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactDetails extends Equatable {
  final String phoneNumber;
  final String city;
  final String? website;

  const ContactDetails({
    required this.city,
    required this.phoneNumber,
    this.website,
  });

  factory ContactDetails.fromFirebaseUser({
    required String city,
    required User user,
    String? website,
  }) {
    return ContactDetails(
      city: city,
      phoneNumber: user.phoneNumber ?? '',
      website: website,
    );
  }

  @override
  List<Object?> get props => [city, phoneNumber, email, website];
}

