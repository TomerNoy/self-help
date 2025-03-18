import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/form_validators.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';
import 'package:self_help/services/services.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = localizations.registration;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.collapsed,
          appBarTitle: title,
        ),
      );
    }

    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.register) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: localizations.name,
                        ),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]'))
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
                        validator: (value) =>
                            FormValidators.passwordMatchValidator(
                          value,
                          passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: GradientFilledButton(
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // ref
                              //     .read(collapsingAppBarProvider.notifier)
                              //     .updateState(AppBarType.login);
                              context.pop(RoutePaths.login.name);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back_ios),
                                Text(localizations.backToLogging),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
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
      // ref
      //     .read(collapsingAppBarProvider.notifier)
      //     .updateState(AppBarType.loading);

      final result = await userService.registerUser(email, password, name);
      if (result.isFailure) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.error!), backgroundColor: Colors.red),
        );
      }
    }
  }
}
