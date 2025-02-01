import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/login/widgets/welcom_language_button.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(localizations.language),
            trailing: WelcomeLanguageButton(),
          ),
        ],
      ),
    );
  }
}
