import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;

    // final focusNode = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 30,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: localizations.email,
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is empty';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Incorrect email format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: localizations.password,
                ),
                obscureText: true,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  }
                  if (value.length < 6) {
                    return 'Password is too short';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: repeatPasswordController,
                decoration: InputDecoration(
                  labelText: localizations.repeatPassword,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              WideButton(
                title: localizations.register,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      if (passwordController.text !=
                          repeatPasswordController.text) {
                        throw Exception('Passwords do not match');
                      }
                      await auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registration successful')),
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration failed: $e')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
