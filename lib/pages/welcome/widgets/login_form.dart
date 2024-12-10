import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/services/services.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({
    super.key,
    required this.collapsedPanelHeight,
  });

  final double collapsedPanelHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final passwordVisible = useState(false);

    final google = SvgPicture.asset(
      'assets/icons/google.svg',
      height: 50,
    );

    return Column(
      children: [
        SizedBox(height: collapsedPanelHeight + 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: localizations.email,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: localizations.password,
                        suffixIcon: IconButton(
                          onPressed: () {
                            passwordVisible.value = !passwordVisible.value;
                          },
                          icon: Icon(
                            passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !passwordVisible.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          label: Text(localizations.forgotPassword),
                          icon: const Icon(Icons.arrow_forward_ios),
                          iconAlignment: IconAlignment.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    WideButton(
                      title: localizations.welcomeButtonTitle,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            loggerService.debug(
                                'Login attempt with email: ${emailController.text.trim()} and password: ${passwordController.text.trim()}');

                            final credential =
                                await auth.signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            // Login successful
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful')),
                            );

                            // Navigate to the home screen
                            Navigator.pushReplacementNamed(context, '/home');
                          } on FirebaseAuthException catch (e, st) {
                            loggerService.error(
                                'Login failed ${e.code}', e.message, st);
                            // Handle login errors
                            String errorMessage;
                            if (e.code == 'user-not-found') {
                              errorMessage = 'No user found for this email.';
                            } else if (e.code == 'wrong-password') {
                              errorMessage = 'Incorrect password.';
                            } else {
                              errorMessage = 'Login failed: ${e.message}';
                            }

                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(localizations.or),
              IconButton(
                onPressed: () {
                  // TODO: Add Google login functionality
                },
                icon: google,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localizations.dontHaveAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Row(
                      children: [
                        Text(localizations.registerNow),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
