import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/overlay/global_overlay.dart';
import 'package:self_help/core/providers/local_language_provider.dart';
import 'package:self_help/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeProvider = ref.watch(localeNotifierProvider);
    final routerConfig = ref.watch(routerProvider);

    return MaterialApp.router(
      locale: localeProvider,
      debugShowCheckedModeBanner: false,
      theme: generateTheme(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        // If the device's locale is unsupported or null, fall back to 'en'
        return supportedLocales.contains(locale) ? locale : const Locale('en');
      },
      routerConfig: routerConfig,
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            CollapsingAppbar(),
            GlobalOverlay(),
          ],
        );
      },
    );
  }
}
