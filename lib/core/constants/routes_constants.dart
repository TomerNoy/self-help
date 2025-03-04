enum RoutePaths {
  home('/'),
  welcome('/welcome'),
  login('/login'),
  register('/register'),
  profile('/profile'),
  settings('/settings'),
  sosLanding('/sos'),
  gainControlLanding('/gainControl'),
  thoughtRelease('/thoughtRelease'),
  resilience('/resilience'),
  calculateExercise('/calculateExercise'),
  lookAroundExercise('/lookAroundExercise'),
  repeatNumber('/repeatNumber'),
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
