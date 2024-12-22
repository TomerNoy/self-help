import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/providers/overlay_provider.dart';
import 'package:self_help/core/form_validators.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/services/services.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();

    // final focusNode = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 230,
          left: 16,
          right: 16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: localizations.name,
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
                validator: FormValidators.nameValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: localizations.email,
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                validator: FormValidators.emailValidator,
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
                validator: FormValidators.passwordValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: repeatPasswordController,
                decoration: InputDecoration(
                  labelText: localizations.repeatPassword,
                ),
                obscureText: true,
                validator: (value) => FormValidators.passwordMatchValidator(
                  value,
                  passwordController.text,
                ),
              ),
              const SizedBox(height: 32),
              WideButton(
                title: localizations.register,
                onPressed: () {
                  _register(
                    formKey,
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                    context,
                    ref,
                  );
                },
                width: double.infinity,
                type: ButtonType.black,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        Text(localizations.backToLoging),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _register(
    GlobalKey<FormState> formKey,
    String email,
    String password,
    String name,
    BuildContext context,
    WidgetRef ref,
  ) async {
    loggerService.debug('user name is: $name');
    if (formKey.currentState!.validate()) {
      final overlayState = ref.read(pageOverlayStateProvider.notifier);
      overlayState.state = PageOverlayState.loading;

      final result = await userService.registerUser(email, password, name);
      overlayState.state = PageOverlayState.hidden;
      if (result.isFailure) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.error!), backgroundColor: Colors.red),
        );
      }
    }
  }
}
