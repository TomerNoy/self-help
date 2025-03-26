import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/models/exercise.dart';

class Exercises {
  static const exercises = [
    Exercise(
      title: 'Calculate',
      description: 'relief stress and anxiety by focusing on the present',
      path: RoutePaths.calculateExercise,
      imagePath: 'assets/images/calculate.jpeg',
    ),
    Exercise(
      title: 'Breathing',
      description: 'relax with breathing exercise',
      path: RoutePaths.breathing,
      imagePath: 'assets/images/breath.jpeg',
    ),
    Exercise(
      title: 'Magic touch',
      description: 'Magic touch',
      path: RoutePaths.magicTouch,
      imagePath: 'assets/icons/self_help_icon.png',
    ),
    Exercise(
      title: 'Thought Release',
      description: 'write bad thoughts and release them',
      path: RoutePaths.thoughtRelease,
      imagePath: 'assets/images/thought_release.jpeg',
    ),
    Exercise(
      title: 'Look Around',
      description: 'notice your surrounding and focus on the present',
      path: RoutePaths.lookAroundExercise,
      imagePath: 'assets/images/look_around.jpeg',
    ),
    Exercise(
      title: 'Reapeat Number',
      description: 'repeat a number to focus on the present',
      path: RoutePaths.repeatNumber,
      imagePath: 'assets/icons/self_help_icon.png',
    ),
    Exercise(
      title: 'Calm Touch',
      description: 'use calm touch exercise to calm your mind',
      path: RoutePaths.calmTouch,
      imagePath: 'assets/icons/self_help_icon.png',
    ),
    Exercise(
      title: 'Butterfly',
      description: 'use butterfly exercise to calm your mind',
      path: RoutePaths.butterfly,
      imagePath: 'assets/icons/self_help_icon.png',
    ),
    Exercise(
      title: 'Butterfly Hug?',
      description: 'use butterfly hug exercise to calm your mind',
      path: RoutePaths.butterflyHug,
      imagePath: 'assets/icons/self_help_icon.png',
    ),
  ];
}
