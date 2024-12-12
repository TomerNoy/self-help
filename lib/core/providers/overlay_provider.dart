import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageOverayState { hidden, loading, offline }

final pageOverlayStateProvider = StateProvider<PageOverayState>((ref) {
  return PageOverayState.hidden;
});
