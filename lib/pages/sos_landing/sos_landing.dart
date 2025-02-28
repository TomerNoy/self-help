import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class SosLanding extends HookConsumerWidget {
  const SosLanding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final routerListener = ref.watch(routerListenerProvider);
    if (routerListener == RoutePaths.sosLanding) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(animatedAppBarProvider.notifier).updateState(
              appBarType: AppBarType.fullScreen,
              fullScreenTitle: localizations.sosMainTitle,
              subtitle: localizations.sosMainInfo,
              startCallback: () {
                final provider = ref.read(pageFlowProvider.notifier);
                provider.startFlow(FlowType.sos);
              },
              hasBackButton: true,
            ),
      );
    }

    return SizedBox.shrink();
  }
}
