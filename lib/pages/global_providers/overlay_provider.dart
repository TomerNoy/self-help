import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageOverlayState { hidden, loading, offline }

final pageOverlayStateProvider = StateProvider<PageOverlayState>((ref) {
  return PageOverlayState.hidden;
});
