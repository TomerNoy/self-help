import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/providers/overlay_provider.dart';

class GlobalOverlay extends ConsumerWidget {
  const GlobalOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayState = ref.watch(pageOverlayStateProvider);

    return switch (overlayState) {
      PageOverlayState.hidden => SizedBox.shrink(),
      PageOverlayState.loading => Positioned.fill(
          child: Container(
            color: Colors.black.withAlpha(100),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      PageOverlayState.offline => SizedBox.shrink(),
    };
  }
}
