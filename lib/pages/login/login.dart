import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/form_validators.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/services/services.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});

  static const scaleAnimationDuration = Duration(milliseconds: 500);
  static const fadeAnimationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final passwordVisible = useState(false);

    final google = SvgPicture.asset(
      AssetsConstants.googleIcon,
      height: 50,
    );

    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);

    return ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
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
                onPressed: () => _login(
                  formKey,
                  emailController.text,
                  passwordController.text,
                  context,
                  ref,
                ),
                type: ButtonType.black,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(localizations.or, textAlign: TextAlign.center),
        IconButton(
          onPressed: () {
            _googleSignIn(
              googleSignIn,
              context,
              ref,
            );
          },
          icon: google,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localizations.dontHaveAccount),
            TextButton(
              onPressed: () {
                // ref
                //     .read(collapsingAppBarProvider.notifier)
                //     .updateState(AppBarType.register);

                context.pushNamed(RoutePaths.register.name);
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
        // todo remove after testing
      ],
    );
  }

  void _login(
    GlobalKey<FormState> formKey,
    String email,
    String password,
    BuildContext context,
    WidgetRef ref,
  ) async {
    if (formKey.currentState!.validate()) {
      // ref
      //     .read(collapsingAppBarProvider.notifier)
      //     .updateState(AppBarType.loading);

      final result = await userService.loginUser(email.trim(), password.trim());

      loggerService.debug('login result: $result');

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

  void _googleSignIn(
    GoogleSignIn googleSignIn,
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      // ref
      //     .read(collapsingAppBarProvider.notifier)
      //     .updateState(AppBarType.loading);
      //todo: is this needed? if so why isn't it on the other login method?
      // ref.read(routerListenerProvider.notifier).updateState(RoutePaths.loading);

      final result = await userService.loginWithGoogle(googleUser);

      if (result.isFailure) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
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
  }
}
