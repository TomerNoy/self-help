import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class Butterfly extends HookConsumerWidget {
  const Butterfly({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = localizations.butterflyHug;
    final subtitle = localizations.butterflyHug;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.expanded,
          appBarTitle: 'Butterfly Hug',
          subtitle: subtitle,
        ),
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.breathing) {
          updateAppBar();
        }
      },
    );
    useEffect(() {
      updateAppBar();
      return null;
    }, const []);

    return SvgPicture.asset(AssetsConstants.butterflyGirl, height: 160);
  }
}
