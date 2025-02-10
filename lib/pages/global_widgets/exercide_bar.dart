import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';

class ExercideBar extends ConsumerWidget {
  const ExercideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return BottomAppBar(
      height: 100,
      color: Colors.transparent,
      child: Column(
        children: [
          WideButton(
            onPressed: () => context.pop(),
            title: localizations.endExercise,
            type: ButtonType.transparent,
          ),
          SizedBox(width: 32),
        ],
      ),
    );
  }
}
