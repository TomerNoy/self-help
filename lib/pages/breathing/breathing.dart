import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/models/breathing_state.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/breathing/providers/breathing_notifier.dart';

class Breathing extends HookConsumerWidget {
  const Breathing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = localizations.breathingExercise;
    final subtitle = localizations.breathingExerciseSubtitle;

    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.breathing,
    );

    final maxSize = Constants.minimumScreenWidth;

    final exerciseState = ref.watch(breathingExerciseProvider);

    final breathingType = exerciseState.breathingState;

    final isPaused = breathingType == BreathingState.stopped;

    final innerCircleTitle = switch (breathingType) {
      BreathingState.breathIn => localizations.breathIn,
      BreathingState.peakHold ||
      BreathingState.baseHold =>
        localizations.holdBreath,
      BreathingState.breathOut => localizations.breathOut,
      BreathingState.prepare => 'Starting in',
      _ => 'Paused',
    };

    //TODO: colors?
    final breathingTypeColor = switch (breathingType) {
      BreathingState.breathIn => Theme.of(context).colorScheme.primary,
      BreathingState.peakHold => Theme.of(context).colorScheme.tertiary,
      BreathingState.breathOut => Theme.of(context).colorScheme.secondary,
      BreathingState.baseHold => Theme.of(context).colorScheme.tertiary,
      _ => Colors.grey.shade300,
    };

    final minScale = maxSize / 2;
    final maxScale = maxSize / 1.5;

    final circleExpanded =
        exerciseState.breathingState == BreathingState.breathIn ||
            exerciseState.breathingState == BreathingState.peakHold;

    final circleSize =
        circleExpanded ? maxScale.toDouble() : minScale.toDouble();

    /// expanding circle inner text
    final expandingCircleInner = isPaused
        ? IconButton(
            onPressed: () {
              ref.read(breathingExerciseProvider.notifier).start();
            },
            icon: FaIcon(
              FontAwesomeIcons.play,
              size: 48,
              color: Colors.black38,
            ),
          )
        : Column(
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
                  switch (breathingType) {
                    BreathingState.prepare => '${exerciseState.prepareCount}',
                    _ => '${exerciseState.stateCount}',
                  },
                  key: ValueKey<String>(
                    exerciseState.breathingState != BreathingState.stopped
                        ? '${exerciseState.stateCount}'
                        : 'empty',
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
      animate: [BreathingState.peakHold, BreathingState.baseHold]
          .contains(exerciseState.breathingState),
      glowRadiusFactor: 0.1,
      duration: const Duration(seconds: 1),
      child: AnimatedContainer(
        duration: switch (exerciseState.breathingState) {
          BreathingState.breathIn =>
            Duration(seconds: exerciseState.stateCount),
          BreathingState.breathOut =>
            Duration(seconds: exerciseState.stateCount),
          _ => const Duration(seconds: 1),
        },
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 5,
          ),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [
              Colors.white,
              Colors.white,
              breathingTypeColor,
              breathingTypeColor,
            ],
            stops: const [0.0, 0.7, 0.9, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CircularProgressIndicator(
                value: exerciseState.breathingScale,
                color: breathingTypeColor,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(breathingTypeColor),
                strokeWidth: 10,
              ),
            ),
            Center(
              child: expandingCircleInner,
            )
          ],
        ),
      ),
    );

    /// stop button
    final stopButton = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isPaused ? 0 : 60,
      width: isPaused ? 0 : 60,
      child: IconButton(
        onPressed: () => ref.read(breathingExerciseProvider.notifier).stop(),
        icon: FittedBox(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.pause,
                size: 30,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );

    // final progressIndicator = Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: LinearProgressIndicator(
    //     value: exerciseState.totalSeconds == 0
    //         ? 0
    //         : (1 / exerciseState.totalSeconds) * exerciseState.secondsLeft,
    //     backgroundColor: Colors.grey.shade300,
    //     valueColor: AlwaysStoppedAnimation<Color>(breathingTypeColor),
    //     borderRadius: BorderRadius.circular(5),
    //     minHeight: 10,
    //   ),
    // );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // flowController.backNoPop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: maxSize,
                      width: maxSize,
                      child: Center(child: expandingCircleWidget),
                    ),
                    // progressIndicator,
                    SizedBox(
                      height: 60,
                      child: Center(child: stopButton),
                    ),
                    SizedBox(
                      height: 60,
                      child: breathingType != BreathingState.stopped &&
                              breathingType != BreathingState.prepare
                          ? Text('seconds left ${exerciseState.secondsLeft}')
                          : null,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.skip,
        ),
        drawer: FlowDrawer(),
      ),
    );
  }
}
