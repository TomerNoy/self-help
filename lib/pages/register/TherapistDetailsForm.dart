import 'package:flutter/material.dart';
import 'package:self_help/models/contact_details.dart'; // Adjust import path as needed
import 'package:self_help/models/app_therapist.dart'; // Adjust import path as needed

class TherapistDetailsForm extends StatefulWidget {
  final String uid;
  final String email;
  final String? displayName;

  const TherapistDetailsForm({
    super.key,
    required this.uid,
    required this.email,
    this.displayName,
  });

  @override
  State<TherapistDetailsForm> createState() => _TherapistDetailsFormState();
}

class _TherapistDetailsFormState extends State<TherapistDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final contactEmailController = TextEditingController();
  final cityController = TextEditingController();
  Gender selectedGender = Gender.other;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Therapist Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Short Bio / Description'),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              const Text('Gender'),
              DropdownButtonFormField<Gender>(
                value: selectedGender,
                onChanged: (value) {
                  setState(() => selectedGender = value!);
                },
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Phone Number'),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              const Text('City'),
              TextFormField(
                controller: cityController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              const Text('Contact Email'),
              TextFormField(
                controller: contactEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const Text('Website'),
              TextFormField(
                controller: websiteController,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contactDetails = ContactDetails(
                      city: cityController.text,
                      phoneNumber: phoneController.text,
                      email: contactEmailController.text,
                      website: websiteController.text,
                    );

                    final therapist = AppTherapist(
                      uid: widget.uid,
                      email: widget.email,
                      displayName: widget.displayName,
                      imagePath: null, // You can add a file picker later
                      description: descriptionController.text,
                      gender: selectedGender,
                      contactDetails: contactDetails,
                    );

                    // Save therapist to Firestore or pass to next screen
                    print('Therapist Created: ${therapist.toString()}');
                    // Navigator.push or pop depending on the flow
                  }
                },
                child: const Text('Finish Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
