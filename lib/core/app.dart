import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/providers/local_language_provider.dart';
import 'package:self_help/routes/app_routes.dart';
import 'package:self_help/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp(
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: generateTheme(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: AppRoutes.generateRoute,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        // If the device's locale is unsupported or null, fall back to 'en'
        return supportedLocales.contains(locale) ? locale : const Locale('en');
      },
    );
  }
}
