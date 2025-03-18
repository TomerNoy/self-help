import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';
import 'package:self_help/pages/global_widgets/exercide_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class FlowNavigationBar extends ConsumerWidget {
  const FlowNavigationBar({
    super.key,
    required this.title,
    this.routeParams = const {},
    this.skip = false,
  });

  final Map<String, String> routeParams;
  final String title;
  final bool skip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(pageFlowProvider).flowType == FlowType.none) {
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GradientOutlinedButton(
                      onPressed: () {
                        final provider = ref.read(pageFlowProvider.notifier);
                        provider.back();
                      },
                      title: localizations.back,
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: GradientFilledButton(
                      onPressed: () {
                        final provider = ref.read(pageFlowProvider.notifier);
                        provider.next(routeParams);
                      },
                      title: skip ? localizations.skip : title,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
