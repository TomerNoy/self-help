import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulsator/pulsator.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/providers/breathing_notifier.dart';
import 'package:self_help/providers/breathing_provider.dart';
import 'package:self_help/theme.dart';

class Breathing extends ConsumerWidget {
  const Breathing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = min(MediaQuery.of(context).size.width * 0.8, 400.0);

    final provider = ref.watch(breathingExerciseProvider);

    final breathingScale = width / 2 + 70 * provider.breathingScale;

    final innerCircleTitle = switch (provider.breathingType) {
      BreathingType.breathIn => 'Breath In',
      BreathingType.peakHold || BreathingType.baseHold => 'Hold',
      BreathingType.breathOut => 'Breath Out',
      _ => 'Paused',
    };

    final breathingType = provider.breathingType;

    final breathingTypeColor = switch (breathingType) {
      BreathingType.breathIn => mintGreen,
      BreathingType.peakHold || BreathingType.baseHold => lightPink,
      BreathingType.breathOut => pastelBlue,
      _ => Colors.grey.shade300,
    };

    /// pulse widget effect
    final pulseWidget =
        provider.timerOn && provider.breathingType != BreathingType.stopped
            ? AnimatedContainer(
                duration: Constants.timerDuration,
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     ),
                width: breathingScale + 70,
                height: breathingScale + 70,
                child: PulseIcon(
                  pulseColor: breathingTypeColor,
                  iconSize: breathingScale - 20,
                  innerSize: breathingScale - 20,
                  pulseCount: 1,
                  pulseDuration: Constants.timerDuration,
                  icon: Icons.circle,
                  pulseSize: breathingScale + 70,
                  iconColor: Colors.red,
                  innerColor: Colors.blue,
                ),
              )
            : const SizedBox.shrink();

    /// expanding circle inner text
    final expandingCircleInnerText = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Text(
            innerCircleTitle,
            key: ValueKey<String>(innerCircleTitle),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Text(
            '${provider.elapsedTime}',
            key: ValueKey<String>(
              provider.timerOn ? '${provider.elapsedTime}' : 'empty',
            ),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ],
    );

    /// expanding circle widget
    final expandingCircleWidget = AnimatedContainer(
      duration: Constants.timerDuration,
      width: breathingScale,
      height: breathingScale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 6 + provider.breathingScale * 5,
        ),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: [
            whiteSmoke,
            whiteSmoke,
            breathingTypeColor,
            breathingTypeColor,
          ],
          stops: const [0.0, 0.7, 0.9, 1.0],
        ),
      ),
      child: Center(
        child: expandingCircleInnerText,
      ),
    );

    /// start stop button
    final startStopButton = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: IconButton(
        key: ValueKey<bool>(provider.timerOn),
        onPressed: () =>
            provider.timerOn ? provider.stop() : provider.startTimer(),
        icon: FaIcon(
          provider.timerOn
              ? FontAwesomeIcons.circleStop
              : FontAwesomeIcons.circlePlay,
          size: 40,
          color: Colors.black38,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: width,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  pulseWidget,
                  expandingCircleWidget,
                ],
              ),
            ),
            startStopButton,
          ],
        ),
      ),
    );
  }
}
