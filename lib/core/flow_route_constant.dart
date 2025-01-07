import 'package:self_help/core/routes_constants.dart';

enum FlowType { sos, gainControl, none }

class FlowLists {
  static const Map<FlowType, List<String>> flowListsMap = {
    FlowType.sos: sos,
    FlowType.gainControl: gainControl,
  };

  static const List<String> sos = [
    RoutNames.stressLevel,
    RoutNames.enterNumber,
    RoutNames.enterNumberReversed,
    RoutNames.breathing,
    RoutNames.stressLevel,
    RoutNames.calculateExercise,
    RoutNames.lookAroundExercise,
    RoutNames.stressLevel,
    RoutNames.gainControlLanding,
    RoutNames.thoughtRelease,
  ];

  static const List<String> gainControl = [
    RoutNames.gainControlLanding,
    RoutNames.lookAroundExercise,
    RoutNames.calculateExercise,
    RoutNames.stressLevel,
    RoutNames.enterNumber,
    RoutNames.enterNumberReversed,
    RoutNames.stressLevel,
    RoutNames.breathing,
    RoutNames.stressLevel,
  ];
}
