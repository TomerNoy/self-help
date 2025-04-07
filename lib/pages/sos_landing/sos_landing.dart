import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

    final appBarNotifier = ref.read(animatedAppBarProvider.notifier);
    final pageFlowNotifier = ref.read(pageFlowProvider.notifier);

    final title = localizations.sosMainTitle;
    final subtitle = localizations.sosMainInfo;

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appBarNotifier.updateState(
          appBarType: AppBarType.fullScreen,
          fullScreenTitle: title,
          subtitle: subtitle,
          startCallback: () => pageFlowNotifier.startFlow(),
          hasBackButton: true,
        ),
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.sosLanding) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);

    return const SizedBox.shrink();
  }
}
