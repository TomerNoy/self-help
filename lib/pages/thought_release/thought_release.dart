import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_widgets/flow_appbar.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';

class ThoughtRelease extends ConsumerWidget {
  const ThoughtRelease({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context)!;

    final cloud = SvgPicture.asset(
      'assets/images/cloud.svg',
      width: 396,
      height: 202,
    );

    final blowing = SvgPicture.asset(
      'assets/images/blowing_dandelion.svg',
      width: 302,
      height: 302,
    );

    return Scaffold(
      appBar: FlowAppBar(
        title: localization.thoughtReleaseTitle,
        subtitle: localization.thoughtReleaseSubtitle,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                cloud,
                WideButton(
                  title: localization.addThoughtButtonTitle,
                  onPressed: () {},
                  type: ButtonType.transparent,
                ),
              ],
            ),
            blowing,
          ],
        ),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localization.skip,
      ),
    );
  }
}
