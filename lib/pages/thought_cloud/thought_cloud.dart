import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';

class ThoughtCloud extends HookConsumerWidget {
  const ThoughtCloud({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = 'thoughtCloud';
    final subtitle = 'thoughtCloud subs';

    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.thoughtCloud,
    );

    return Scaffold(
      body: Center(
        child: Text('Thought Cloud'),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localizations.continueButtonTitle,
      ),
    );
  }
}
