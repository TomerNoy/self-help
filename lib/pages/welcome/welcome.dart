import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/services.dart';

class Welcome extends ConsumerWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerListener = ref.watch(routerListenerProvider);
    final localizations = AppLocalizations.of(context)!;
    
    loggerService.debug('§ Welcome ${routerListener.name}');

    if (routerListener == RoutePaths.welcome) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(animatedAppBarProvider.notifier).updateState(
            appBarType: AppBarType.fullScreen,
            logo: AssetsConstants.selfHelpNoBk,
            fullScreenTitle: localizations.welcomeTitle,
            subtitle: localizations.welcomeSubtitle,
            startCallback: () {
              final provider = ref.read(routerStateProvider);
              provider.pushNamed(RoutePaths.login.name);
            }),
      );
    }
    return SizedBox.shrink();
  }
}
