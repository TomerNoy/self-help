import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class FlowNavigationBar extends StatelessWidget {
  const FlowNavigationBar({
    super.key,
    required this.onPressed,
    required this.title,
    this.routeParams = const {},
  });

  final Map<String, String> routeParams;
  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: WideButton(
              onPressed: () {
                context.pop();
              },
              title: localizations.back,
              type: ButtonType.transparent,
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            child: WideButton(
              onPressed: onPressed,
              title: title,
              type: ButtonType.gradient,
            ),
          ),
        ],
      ),
    );
  }
}
