import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/models/exercise.dart';

class Exercises {
  static const exercises = [
    Exercise(
      title: 'Calculate',
      description: 'relief stress and anxiety by focusing on the present',
      path: RoutePaths.calculateExercise,
      imagePath: 'assets/images/exercise.svg',
    ),
    Exercise(
      title: 'Breathing',
      description: 'Breathing',
      path: RoutePaths.breathing,
      imagePath: 'assets/images/exercise.svg',
    ),
    Exercise(
      title: 'Magic touch',
      description: 'Magic touch',
      path: RoutePaths.magicTouch,
      imagePath: 'assets/images/exercise.svg',
    ),
    Exercise(
      title: 'Thought Release',
      description: 'Thought Release',
      path: RoutePaths.thoughtRelease,
      imagePath: 'assets/images/exercise.svg',
    ),
    Exercise(
      title: 'Look Around',
      description: 'Look Around',
      path: RoutePaths.lookAroundExercise,
      imagePath: 'assets/images/exercise.svg',
    ),
    Exercise(
      title: 'Reapeat Number',
      description: 'Reapeat Number',
      path: RoutePaths.repeatNumber,
      imagePath: 'assets/images/exercise.svg',
    ),
  ];
}
