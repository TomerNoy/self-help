import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/providers/breathing_notifier.dart';

final breathingExerciseProvider =
    ChangeNotifierProvider.autoDispose<BreathingExerciseNotifier>(
  (ref) => BreathingExerciseNotifier(),
);
