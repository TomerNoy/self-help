import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/home_shell/home_shell.dart';

class ResilienceShell extends HookConsumerWidget {
  const ResilienceShell({
    super.key,
    required this.child,
    required this.page,
  });

  final Widget child;

  final RoutePaths? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final profileButtonIsExpanded = page == RoutePaths.profile;
    final settingsButtonIsExpanded = page == RoutePaths.settings;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.collapsed,
          appBarTitle: 'Resilience', // TODO: replace with title
        ),
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.resilience) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        height: 60,
        shape: const CircularNotchedRectangle(),
        color: blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // todo: replace with new routes
            AnimatedIconButton(
              iconData: Icons.person,
              label: localizations.profile,
              onPressed: () {
                // final provider = ref.read(routerStateProvider);
                // provider.pushNamed(RoutePaths.profile.name);
              },
              isExpanded: profileButtonIsExpanded,
            ),
            AnimatedIconButton(
              label: localizations.settings,
              iconData: Icons.settings,
              onPressed: () {
                // final provider = ref.read(routerStateProvider);
                // provider.pushNamed(RoutePaths.settings.name);
              },
              isExpanded: settingsButtonIsExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
