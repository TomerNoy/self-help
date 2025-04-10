import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

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
    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.collapsed,
          appBarTitle: 'Resilience',
          hasBackButton: true,
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
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: child,
    );
  }
}
