import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/widgets/form_validators.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/routes/router.dart';
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

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final passwordVisible = useState(false);

    final google = SvgPicture.asset(
      'assets/icons/google.svg',
      height: 50,
    );

    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);

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
                      validator: FormValidators.emailValidator,
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
                      validator: FormValidators.passwordValidator,
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
                      onPressed: () => _login(formKey, emailController,
                          passwordController, context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(localizations.or),
              IconButton(
                onPressed: () async {
                  try {
                    final googleUser = await googleSignIn.signIn();
                    if (googleUser == null) return;
                    userService.loginWithGoogle(googleUser);
                  } catch (e, st) {
                    loggerService.error('Google sign in failed', e, st);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('googleSignInFailed'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: google,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localizations.dontHaveAccount),
                  TextButton(
                    onPressed: () => context.pushNamed(AppRoutes.register),
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

  void _login(
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      final result = await userService.loginUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (result.isFailure) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
