import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:pulsator/pulsator.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/providers/breathing_notifier.dart';
import 'package:self_help/providers/breathing_provider.dart';
import 'package:self_help/services/services.dart';
import 'package:self_help/theme.dart';

class Breathing extends ConsumerWidget {
  const Breathing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = min(MediaQuery.of(context).size.width * 0.8, 400.0);

    final provider = ref.watch(breathingExerciseProvider);

    final innerCircleTitle = switch (provider.breathingType) {
      BreathingType.breathIn => 'Breath In',
      BreathingType.peakHold || BreathingType.baseHold => 'Hold',
      BreathingType.breathOut => 'Breath Out',
      _ => 'Paused',
    };

    final breathingType = provider.breathingType;

    //todo: colors?
    final breathingTypeColor = switch (breathingType) {
      BreathingType.breathIn => Colors.grey.shade400,
      BreathingType.peakHold => Colors.grey.shade400,
      BreathingType.baseHold => Colors.grey.shade400,
      BreathingType.breathOut => Colors.grey.shade400,
      _ => Colors.grey.shade300,
    };

    final minScale = width / 2;
    final maxScale = width / 1.5;

    final circleExpanded = provider.breathingType == BreathingType.breathIn ||
        provider.breathingType == BreathingType.peakHold;

    final circleSize =
        circleExpanded ? maxScale.toDouble() : minScale.toDouble();

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
    final expandingCircleWidget = AvatarGlow(
      glowColor: breathingTypeColor,
      glowCount: 3,
      animate:
          provider.timerOn && provider.breathingType != BreathingType.stopped,
      glowRadiusFactor: 0.1,
      duration: const Duration(seconds: 1),
      child: AnimatedContainer(
        duration: switch (provider.breathingType) {
          BreathingType.breathIn =>
            Duration(seconds: provider.breathInDuration),
          BreathingType.breathOut =>
            Duration(seconds: provider.breathOutDuration),
          _ => const Duration(seconds: 1),
        },
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: circleExpanded ? 10 : 1,
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
              child: Center(child: expandingCircleWidget),
            ),
            startStopButton,
          ],
        ),
      ),
    );
  }
}
