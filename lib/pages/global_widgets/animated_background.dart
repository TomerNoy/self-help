import 'package:flutter/material.dart';
import 'package:dynamic_background/dynamic_background.dart';
import 'package:self_help/core/constants/routes_constants.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    super.key,
    required this.page,
  });

  final RoutePaths? page;

  @override
  Widget build(BuildContext context) {
    final key = ValueKey(page);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: switch (page) {
          RoutePaths.sosLanding => SizedBox.shrink(key: key),
          RoutePaths.home ||
          RoutePaths.stressLevel ||
          RoutePaths.repeatNumber =>
            Waves(
              color: Theme.of(context).colorScheme.secondary.withAlpha(50),
              key: key,
            ),
          _ => Waves(
              color: Theme.of(context).colorScheme.tertiary.withAlpha(100),
              key: key,
            ),
        },
      ),
    );
  }
}

class Waves extends StatelessWidget {
  const Waves({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final numberOfWaves = 3;

    return DynamicBg(
      key: key,
      duration: const Duration(seconds: 10),
      painterData: WavePainterData(
        waves: List.generate(
          numberOfWaves,
          (index) {
            final amplitude = 30.0 + index * 30;
            final offset = 0.50 + index * 0.05;
            final lineThickness = 0.5;
            final phase = 0.2 + index * 0.2;

            return Wave(
              amplitude: amplitude,
              offset: offset,
              color: color,
              lineThickness: lineThickness,
              phase: phase,
            );
          },
        ),
      ),
    );
  }
}

class Lava extends StatelessWidget {
  const Lava({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DynamicBg(
      duration: const Duration(seconds: 5),
      painterData: WavePainterData(
        waves: [
          Wave(
            direction: WaveDirection.left2Right,
            amplitude: 50.0,
            offset: 0.5,
            color: Colors.transparent,
            lineColor: Theme.of(context).colorScheme.primary,
            lineThickness: 3.0,
            phase: 0.0,
          ),
          Wave(
            direction: WaveDirection.left2Right,
            amplitude: 45.0,
            offset: 0.3,
            color: Colors.transparent,
            lineColor: Theme.of(context).colorScheme.secondary,
            lineThickness: 3.0,
            phase: 0.3,
          ),
          Wave(
            direction: WaveDirection.left2Right,
            amplitude: 40.0,
            offset: 0.4,
            color: Colors.transparent,
            lineColor: Theme.of(context).colorScheme.tertiary,
            lineThickness: 3.0,
            phase: 0.5,
          ),
        ],
      ),
      // child: yourPageHere(),
    );
  }
}
