import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/flow_appbar.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/breathing/providers/breathing_notifier.dart';
import 'package:self_help/services/services.dart';

class Breathing extends ConsumerWidget {
  const Breathing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final maxSize = Constants.minimumScreenWidth;

    final provider = ref.watch(breathingExerciseProvider);
    final notifier = ref.watch(breathingExerciseProvider.notifier);

    final breathingType = provider.breathingType;

    final isPaused = breathingType == BreathingType.stopped;

    final innerCircleTitle = switch (breathingType) {
      BreathingType.breathIn => localizations.breathIn,
      BreathingType.peakHold ||
      BreathingType.baseHold =>
        localizations.holdBreath,
      BreathingType.breathOut => localizations.breathOut,
      _ => 'Paused',
    };

    //todo: colors?
    final breathingTypeColor = switch (breathingType) {
      BreathingType.breathIn => breathStepIndicatorColor,
      BreathingType.peakHold => Colors.grey.shade400,
      BreathingType.breathOut => breathStepIndicatorColor,
      BreathingType.baseHold => Colors.grey.shade400,
      _ => Colors.grey.shade300,
    };

    final minScale = maxSize / 2;
    final maxScale = maxSize / 1.5;

    final circleExpanded = provider.breathingType == BreathingType.breathIn ||
        provider.breathingType == BreathingType.peakHold;

    final circleSize =
        circleExpanded ? maxScale.toDouble() : minScale.toDouble();

    /// expanding circle inner text
    final expandingCircleInner = isPaused
        ? IconButton(
            onPressed: () =>
                ref.read(breathingExerciseProvider.notifier).startTimer(),
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
                  '${provider.timerCount}',
                  key: ValueKey<String>(
                    provider.breathingType != BreathingType.stopped
                        ? '${provider.timerCount}'
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
      animate: [BreathingType.peakHold, BreathingType.baseHold]
          .contains(provider.breathingType),
      glowRadiusFactor: 0.1,
      duration: const Duration(seconds: 1),
      child: AnimatedContainer(
        duration: switch (provider.breathingType) {
          BreathingType.breathIn =>
            Duration(seconds: notifier.breathInDuration),
          BreathingType.breathOut =>
            Duration(seconds: notifier.breathOutDuration),
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
                value: notifier.breathingScale,
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

    /// start stop button
    final stopButton = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: IconButton(
        key: ValueKey<bool>(provider.breathingType != BreathingType.stopped),
        onPressed: () => ref.read(breathingExerciseProvider.notifier).stop(),
        icon: Container(
          height: 40,
          width: 40,
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
    );

    loggerService.debug('breathing scale: ${notifier.breathingScale}');

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // flowController.backNoPop();
        }
      },
      child: Stack(
        children: [
          SizedBox.expand(
            child: AnimatedBackground(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: FlowAppBar(
              title: localizations.breathingExercise,
              subtitle: localizations.breathingExerciseSubtitle,
            ),
            body: Column(
              children: [
                SingleChildScrollView(
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
                          if (!isPaused) stopButton,
                          SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: FlowNavigationBar(
              title: localizations.skip,
            ),
            drawer: FlowDrawer(),
          ),
        ],
      ),
    );
  }
}
