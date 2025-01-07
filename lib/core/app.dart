import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/local_language_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      locale: ref.watch(localeNotifierProvider),
      debugShowCheckedModeBanner: false,
      theme: generateTheme(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        // If the device's locale is unsupported or null, fall back to 'en'
        return supportedLocales.contains(locale) ? locale : const Locale('en');
      },
      routerConfig: ref.watch(routerStateProvider),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            CollapsingAppbar(),
            // DebugOverlay(),
          ],
        );
      },
    );
  }
}
