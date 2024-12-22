import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppBarState { hidden, collapsed, expanded }

final collapsingAppBarProvider = StateProvider<AppBarState>((ref) {
  return AppBarState.expanded;
});
