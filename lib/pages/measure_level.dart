import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/widgets/flow_appbar.dart';
import 'package:self_help/core/widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/providers/level_provider.dart';
import 'package:self_help/routes/router.dart';
import 'package:self_help/services/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeasureLevel extends ConsumerWidget {
  const MeasureLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider.select((value) => value.state));
    final localizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FlowAppBar(
        title: localizations.measureTitle,
        subtitle: localizations.measureSubtitle,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                '$level/10',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                width: screenWidth / 1.5,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 10.001,
                      axisLineStyle: const AxisLineStyle(
                        cornerStyle: CornerStyle.bothCurve,
                        thickness: 0.15,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      showLabels: true,
                      canScaleToFit: true,
                      showTicks: false,
                      // startAngle: -80,
                      // endAngle: -100,
                      pointers: <GaugePointer>[
                        RangePointer(
                          gradient: const SweepGradient(
                            colors: [
                              Color(0xFF79C3DD),
                              Color(0xFF6E79ED),
                            ],
                          ),
                          width: 0.2,
                          value: level.toDouble(),
                          cornerStyle: CornerStyle.bothCurve,
                          sizeUnit: GaugeSizeUnit.factor,
                          enableAnimation: true,
                        ),
                        MarkerPointer(
                          animationType: AnimationType.ease,
                          value: level.toDouble(),
                          // elevation: 5,
                          color: Color(0xFF6E79ED),
                          // borderWidth: 4,
                          onValueChanged: (value) {
                            loggerService.debug(
                              'onValueChanged value $value, round ${value.round()}',
                            );
                            ref.read(levelProvider.notifier).state =
                                value.round();
                          },
                          enableDragging: true,
                          markerHeight: 30,
                          markerWidth: 30,
                          markerType: MarkerType.circle,
                          enableAnimation: true,
                          animationDuration: 300,
                          borderColor: Colors.white,
                          borderWidth: 3,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Icon(
                            switch (level) {
                              1 ||
                              2 =>
                                CommunityMaterialIcons.emoticon_cry_outline,
                              3 ||
                              4 =>
                                CommunityMaterialIcons.emoticon_sad_outline,
                              5 ||
                              6 =>
                                CommunityMaterialIcons.emoticon_neutral_outline,
                              7 ||
                              8 =>
                                CommunityMaterialIcons.emoticon_happy_outline,
                              9 ||
                              10 =>
                                CommunityMaterialIcons.emoticon_excited_outline,
                              _ => CommunityMaterialIcons.minus
                            },
                            size: 100,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(32),
                  isSelected: [
                    level == 9 || level == 10,
                    level == 7 || level == 8,
                    level == 5 || level == 6,
                    level == 3 || level == 4,
                    level == 1 || level == 2,
                  ],
                  children: [
                    PreasureIcon(
                      icon: CommunityMaterialIcons.emoticon_excited_outline,
                      title: localizations.good,
                    ),
                    PreasureIcon(
                      icon: CommunityMaterialIcons.emoticon_happy_outline,
                      title: localizations.ok,
                    ),
                    PreasureIcon(
                      icon: CommunityMaterialIcons.emoticon_neutral_outline,
                      title: localizations.neutral,
                    ),
                    PreasureIcon(
                      icon: CommunityMaterialIcons.emoticon_sad_outline,
                      title: localizations.sad,
                    ),
                    PreasureIcon(
                      icon: CommunityMaterialIcons.emoticon_cry_outline,
                      title: localizations.anxious,
                    ),
                  ],
                  onPressed: (index) => ref.read(levelProvider.notifier).state =
                      [10, 8, 5, 3, 1][index],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localizations.continueButtonTitle,
        onPressed: () {
          context.pushNamed(
            AppRoutes.enterNumber,
          );
        },
      ),
    );
  }
}

class PreasureIcon extends ConsumerWidget {
  const PreasureIcon({
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
