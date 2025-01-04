import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/local_language_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/overlay/global_overlay.dart';

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
            GlobalOverlay(),
            DebugPanel(),
          ],
        );
      },
    );
  }
}

// debug panel
class DebugPanel extends ConsumerWidget {
  const DebugPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          AppBarType.values.length,
          (index) {
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () {
                ref
                    .watch(collapsingAppBarProvider.notifier)
                    .updateState(AppBarType.values[index]);
              },
              child: Text(
                AppBarType.values[index].name.toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            );
          },
        ),
      ),
    );
  }
}
