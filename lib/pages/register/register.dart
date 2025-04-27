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
import './TherapistDetailsForm.dart';
import 'package:self_help/models/app_therapist.dart';
import 'package:self_help/models/contact_details.dart';

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

    // New Therapist Controllers
    final descriptionController = useTextEditingController();
    final phoneController = useTextEditingController();
    final websiteController = useTextEditingController();
    final contactEmailController = useTextEditingController();
    final selectedGender = useState(Gender.other);
    final cityController = useTextEditingController(); // NEW


    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isTherapist = useState(false); // NEW

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
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: localizations.name),
                        keyboardType: TextInputType.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        validator: FormValidators.nameValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: localizations.email),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                        validator: FormValidators.emailValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: localizations.password),
                        obscureText: true,
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                        validator: FormValidators.passwordValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: repeatPasswordController,
                        decoration: InputDecoration(labelText: localizations.repeatPassword),
                        obscureText: true,
                        validator: (value) => FormValidators.passwordMatchValidator(
                          value,
                          passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // NEW: Is Therapist? Radio Buttons
                      Row(
                        children: [
                          Text(localizations.areYouTherapist),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: isTherapist.value,
                                onChanged: (value) => isTherapist.value = value!,
                              ),
                              Text(localizations.yes),
                              Radio<bool>(
                                value: false,
                                groupValue: isTherapist.value,
                                onChanged: (value) => isTherapist.value = value!,
                              ),
                              Text(localizations.no),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // If therapist -> show additional fields
                      if (isTherapist.value) ...[
                        const Divider(),
                        const Text("Therapist Details", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter a description' : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Gender>(
                          value: selectedGender.value,
                          onChanged: (value) => selectedGender.value = value!,
                          items: Gender.values.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender.name),
                            );
                          }).toList(),
                          decoration: const InputDecoration(labelText: 'Gender'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(labelText: 'City'),
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter a city' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: websiteController,
                          decoration: const InputDecoration(labelText: 'Website'),
                          keyboardType: TextInputType.url,
                        ),
                        const SizedBox(height: 24),
                      ],

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
                              isTherapist.value,
                              descriptionController.text,
                              selectedGender.value,
                              phoneController.text,
                              cityController.text,
                              websiteController.text,
                              context,
                              ref,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context.pop(RoutePaths.login.name),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios),
                            Text(localizations.backToLogging),
                          ],
                        ),
                      ),
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
      bool isTherapist,
      String description,
      Gender gender,
      String phone,
      String city,
      String website,
      BuildContext context,
      WidgetRef ref,
      ) async {
    if (formKey.currentState!.validate()) {
      final result = await userAuthService.registerUser(email, password, name);
      if (result.isFailure) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.error!), backgroundColor: Colors.red),
        );
        return;
      }

      final user = result.data;
      if (user == null) return;

      if (isTherapist) {
        final contactDetails = ContactDetails(
          city: city,
          phoneNumber: phone,
          website: website,
        );
        final therapist = AppTherapist(
          uid: user.uid,
          email: user.email!,
          displayName: user.displayName,
          description: description,
          gender: gender,
          contactDetails: contactDetails,
        );
        // Save therapist to Firestore or whatever you want here
      } else {
        // Save regular user or navigate
      }

      context.go(RoutePaths.home.name);
    }
  }

}
