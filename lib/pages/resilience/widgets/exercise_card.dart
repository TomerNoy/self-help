import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/exercises.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class ExerciseCard extends ConsumerWidget {
  const ExerciseCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = Exercises.exercises[index];
    final title = exercise.title;
    final description = exercise.description;
    final imagePath = exercise.imagePath;
    final pathName = exercise.path.name;

    return InkWell(
      onTap: () => ref.read(routerStateProvider).pushNamed(pathName),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    Flexible(
                      child: Text(description),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
