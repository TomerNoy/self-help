import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_widgets/exercide_bar.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class FlowNavigationBar extends ConsumerWidget {
  const FlowNavigationBar({
    super.key,
    required this.title,
    this.routeParams = const {},
    this.disabled = false,
  });

  final Map<String, String> routeParams;
  final String title;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(pageFlowProvider).flowType == FlowType.none) {
      return ExercideBar();
    }
    final localizations = AppLocalizations.of(context)!;
    return BottomAppBar(
      height: 100,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: WideButton(
                  onPressed: () {
                    final provider = ref.read(pageFlowProvider.notifier);
                    provider.back();
                  },
                  title: localizations.back,
                  type: ButtonType.transparent,
                ),
              ),
              SizedBox(width: 32),
              Expanded(
                child: WideButton(
                  onPressed: disabled
                      ? null
                      : () {
                          final provider = ref.read(pageFlowProvider.notifier);
                          provider.next(routeParams);
                        },
                  title: title,
                  type: ButtonType.gradient,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
