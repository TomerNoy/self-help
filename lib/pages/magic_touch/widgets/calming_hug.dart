import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class CalmingHug extends ConsumerWidget {
  const CalmingHug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          localizations.calmingTouch,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 16),
        SvgPicture.asset(AssetsConstants.breathingGirl, height: 160),
      ],
    );
  }
}
