import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class Welcome extends HookConsumerWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final title = localizations.welcomeTitle;
    final subtitle = localizations.welcomeSubtitle;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);
    final routerProvider = ref.read(routerStateProvider);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
            appBarType: AppBarType.fullScreen,
            logo: AssetsConstants.selfHelpNoBk,
            fullScreenTitle: title,
            subtitle: subtitle,
            startCallback: () {
              routerProvider.pushNamed(RoutePaths.login.name);
            }),
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.welcome) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);
    return SizedBox.shrink();
  }
}
