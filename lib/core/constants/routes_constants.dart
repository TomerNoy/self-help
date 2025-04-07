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
  butterfly('/butterfly'),
  butterflyHug('/butterflyHug'),
  calmTouch('/calmTouch'),
  forAgainst('/forAgainst'),
  eights('/eights'),
  resilience('/resilience'),
  calculateExercise('/calculateExercise'),
  thoughtManagement('/thoughtManagement'),
  thoughtIdentify('/thoughtIdentify'),
  question('/question'),
  thoughtCloud('/thoughtCloud'),
  lookAroundExercise('/lookAroundExercise'),
  repeatNumber('/repeatNumber'),
  stressLevel('/stressLevel'),
  magicTouch('/magicTouch'),
  emergency('/emergency'), 
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
