import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

void useAppBarManager({
  required WidgetRef ref,
  required String title,
  required String subtitle,
  required RoutePaths routePath,
}) {
  final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

  void updateAppBar() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => appbarNotifier.updateState(
        appBarType: AppBarType.expanded,
        appBarTitle: title,
        subtitle: subtitle,
        hasBackButton: true,
      ),
    );
  }

  ref.listen(
    routerListenerProvider,
    (previous, next) {
      if (next != previous && next == routePath) {
        updateAppBar();
      }
    },
  );

  useEffect(() {
    updateAppBar();
    return null;
  }, const []);
}
