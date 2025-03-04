import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/models/exercise.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class Resilience extends ConsumerWidget {
  const Resilience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final exercises = [
      Exercise(
        title: 'Calculate',
        description: 'relief stress and anxiety by focusing on the present',
        path: RoutePaths.calculateExercise,
      ),
      Exercise(
        title: 'Breathing',
        description: 'Breathing',
        path: RoutePaths.breathing,
      ),
      Exercise(
        title: 'Magic touch',
        description: 'Magic touch',
        path: RoutePaths.magicTouch,
      ),
      Exercise(
        title: 'Thought Release',
        description: 'Thought Release',
        path: RoutePaths.thoughtRelease,
      ),
      Exercise(
        title: 'Look Around',
        description: 'Look Around',
        path: RoutePaths.lookAroundExercise,
      ),
      Exercise(
        title: 'Reapeat Number',
        description: 'Reapeat Number',
        path: RoutePaths.repeatNumber,
      ),
    ];

    return Scaffold(
      body: ListView(
        children: List.generate(
          exercises.length,
          (index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.task),
                title: Text(exercises[index].title),
                subtitle: Text(exercises[index].description),
                onTap: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(exercises[index].path.name);
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'exercises',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu_book),
      //       label: 'diary',
      //     ),
      //   ],
      //   onTap: (index) {
      //     final provider = ref.read(routerStateProvider);
      //     switch (index) {
      //       case 0:
      //         // provider.pushNamed(RoutePaths.home.name);
      //         break;
      //       case 1:
      //         // provider.pushNamed(RoutePaths.profile.name);
      //         break;
      //     }
      //   },
      // ),
    );
  }
}
