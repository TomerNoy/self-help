import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';

class Eights extends HookConsumerWidget {
  const Eights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = 'eights';
    final subtitle = 'eights subs';
    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.eights,
    );
    return Scaffold(
      body: Center(
        child: Text('Eights'),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localizations.continueButtonTitle,
      ),
    );
  }
}
