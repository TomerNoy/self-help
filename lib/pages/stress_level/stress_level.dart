import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_widgets/flow_appbar.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/stress_level/providers/stress_level_provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class StressLevel extends ConsumerWidget {
  const StressLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(stressLevelProvider);
    final localizations = AppLocalizations.of(context)!;
    final width = Constants.minimumScreenWidth;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(pageFlowProvider.notifier).didPop();
        }
      },
      child: Scaffold(
        appBar: FlowAppBar(
          title: localizations.measureTitle,
          subtitle: localizations.measureSubtitle,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: width,
                  child: SleekCircularSlider(
                    min: 1,
                    max: 10,
                    initialValue: 5,
                    appearance: CircularSliderAppearance(
                      startAngle: 180,
                      angleRange: 180,
                      customWidths: CustomSliderWidths(
                        progressBarWidth: 50,
                        trackWidth: 50,
                        shadowWidth: 0,
                        handlerSize: 20,
                      ),
                      customColors: CustomSliderColors(
                        progressBarColors: [
                          gradientStartColor,
                          gradientEndColor,
                        ],
                        trackColor: greyBackgroundColor,
                        shadowColor: Colors.transparent,
                      ),
                      infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChange: (value) {
                      ref
                          .read(stressLevelProvider.notifier)
                          .updateState(value.round());
                    },
                    innerWidget: (_) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            switch (level) {
                              1 ||
                              2 =>
                                CommunityMaterialIcons.emoticon_excited_outline,
                              3 ||
                              4 =>
                                CommunityMaterialIcons.emoticon_happy_outline,
                              5 ||
                              6 =>
                                CommunityMaterialIcons.emoticon_neutral_outline,
                              7 ||
                              8 =>
                                CommunityMaterialIcons.emoticon_sad_outline,
                              9 ||
                              10 =>
                                CommunityMaterialIcons.emoticon_cry_outline,
                              _ => CommunityMaterialIcons.minus
                            },
                            size: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'לחוץ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '$level/10',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                'רגוע',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.continueButtonTitle,
        ),
        drawer: FlowDrawer(),
      ),
    );
  }
}

class PressureIcon extends ConsumerWidget {
  const PressureIcon({
    required this.icon,
    required this.title,
    super.key,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
