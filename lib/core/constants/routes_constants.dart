enum RoutePaths {
  loading('/'),
  login('/login'),
  register('/register'),
  enterNumber('/enterNumber'),
  profile('/profile'),
  settings('/settings'),
  enterNumberReversed('/enterNumberReversed:userNumber'),
  connecting('/connecting'),
  home('/home'),
  sosLanding('/sos'),
  gainControlLanding('/gainControl'),
  thoughtRelease('/thoughtRelease'),
  calculateExercise('/calculateExercise'),
  lookAroundExercise('/lookAroundExercise'),
  stressLevel('/stressLevel'),
  magicTouch('/magicTouch'),
  emergency('/emergency'),
  butterfly('/butterfly'),
  breathing('/breathing');

  final String path;

  const RoutePaths(this.path);

  static RoutePaths? fromPath(String path) {
    return RoutePaths.values.firstWhere(
      (e) => e.path == path,
      orElse: () =>
          throw ArgumentError('No RoutePaths enum value with path: $path'),
    );
  }
}
