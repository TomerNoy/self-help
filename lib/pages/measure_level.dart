import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/core/widgets/page_navigator.dart';
import 'package:self_help/pages/widgets/page_app_bar.dart';
import 'package:self_help/providers/level_provider.dart';
import 'package:self_help/providers/page_route_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeasureLevel extends ConsumerWidget {
  const MeasureLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowController = ref.read(pageRouteProvider);
    final level = ref.watch(levelProvider.select((value) => value.state));
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          flowController.backNoPop();
        }
      },
      child: Scaffold(
        appBar: PageAppBar(title: 'Measure Level'),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'מה מידת הלחץ שלך כרגע?',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'מזכיר שהמטרה בשלב הראשון היא להוריד את עוצמת הלחץ והתגובות הפיזיולוגיות. תרגיל זה עוזר בכך. זהו השלב הראשון. כאילו ולוחצים על הברקס על מנת לנהל את המצב המלחיץ.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.black),
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          width: 300,
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: 10,

                                // radiusFactor: 1,
                                axisLineStyle: const AxisLineStyle(
                                  cornerStyle: CornerStyle.bothCurve,
                                  color: Colors.black26,
                                  thickness: 0.1,
                                  thicknessUnit: GaugeSizeUnit.factor,
                                ),

                                // showLabels: false,
                                // showAxisLine: true,
                                // showFirstLabel: true,
                                canScaleToFit: true,
                                showLastLabel: true,
                                // showTicks: true,
                                // labelOffset: 20,
                                startAngle: 180,
                                endAngle: 0,
                                // interval: 10,
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    width: 0.2,
                                    value: level.toDouble(),
                                    cornerStyle: CornerStyle.bothCurve,
                                    // color: Colors.purple,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    // color: Colors.black12,
                                    enableAnimation: true,
                                  ),
                                  MarkerPointer(
                                    animationType: AnimationType.ease,
                                    value: level.toDouble(),
                                    elevation: 5,
                                    color: Colors.black54,
                                    borderWidth: 4,
                                    onValueChanged: (value) {
                                      ref.read(levelProvider.notifier).state =
                                          value.round();
                                      print('onValueChanged value is $value');
                                    },
                                    enableDragging: true,
                                    // borderColor: Colors.black87,
                                    markerHeight: 40,
                                    markerWidth: 40,
                                    markerType: MarkerType.circle,
                                    enableAnimation: true,
                                    animationDuration: 300,
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    widget: Text(
                                      '$level',
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                ref.read(levelProvider.notifier).decrement();
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.circleDown,
                                size: 40,
                                color: Colors.black38,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                ref.read(levelProvider.notifier).increment();
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.circleUp,
                                size: 40,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            StepNavigator(),
          ],
        ),
      ),
    );
  }
}
