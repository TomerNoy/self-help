import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/providers/level_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeasureLevel extends ConsumerWidget {
  const MeasureLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider.select((value) => value.state));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measure Level'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
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
                        color: Colors.black12,
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
                        borderColor: Colors.black87,
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
                  icon: const Icon(Icons.arrow_downward),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    ref.read(levelProvider.notifier).increment();
                  },
                  icon: const Icon(Icons.arrow_upward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
