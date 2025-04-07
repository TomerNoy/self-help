import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';
import 'package:self_help/pages/global_widgets/exercide_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class FlowNavigationBar extends ConsumerWidget {
  const FlowNavigationBar({
    super.key,
    required this.title,
    this.stressType,
    this.skip = false,
    this.onContinue,
  });

  final StressType? stressType;
  final String title;
  final bool skip;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(pageFlowProvider).flowList.isEmpty) {
      return ExercideBar();
    }
    final localizations = AppLocalizations.of(context)!;
    return BottomAppBar(
      height: 100,
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          child: Center(
            child: GradientFilledButton(
              onPressed: () {
                if (onContinue != null) {
                  onContinue!();
                }
                final provider = ref.read(pageFlowProvider.notifier);
                provider.next(stressType);
              },
              title: skip ? localizations.skip : title,
            ),
          ),
        ),
      ),
    );
  }
}
