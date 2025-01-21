import 'package:self_help/core/constants/routes_constants.dart';

enum FlowType { sos, gainControl, none }

class FlowLists {
  static Map<FlowType, List<String>> flowListsMap = {
    FlowType.sos: sos,
    FlowType.gainControl: gainControl,
    FlowType.none: [],
  };

  static List<String> sos = [
    RoutePaths.stressLevel.name,
    RoutePaths.enterNumber.name,
    RoutePaths.enterNumberReversed.name,
    RoutePaths.breathing.name,
    RoutePaths.stressLevel.name,
    RoutePaths.magicTouch.name,
    RoutePaths.stressLevel.name,
    RoutePaths.calculateExercise.name,
    RoutePaths.lookAroundExercise.name,
    RoutePaths.stressLevel.name,
  ];

  static List<String> gainControl = [
    RoutePaths.gainControlLanding.name,
    RoutePaths.thoughtRelease.name,
    RoutePaths.stressLevel.name,
  ];
}
