import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/exercises.dart';
import 'package:self_help/pages/resilience/widgets/exercise_card.dart';

class Resilience extends ConsumerWidget {
  const Resilience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8 / 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: Exercises.exercises.length,
        itemBuilder: (context, index) {
          return ExerciseCard(
            index: index,
          );
        },
      ),
    );
  }
}
