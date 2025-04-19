import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/pages/global_providers/app_overlay_provider.dart';

class AppOverlay extends ConsumerWidget {
  const AppOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayState = ref.watch(appOverlayProvider);

    return switch (overlayState.type) {
      AppOverlayType.hidden || AppOverlayType.error => SizedBox.shrink(),
      AppOverlayType.loading => Scaffold(
          backgroundColor: Colors.white54,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ...List.generate(3, (index) {
                  final color = Theme.of(context).primaryColor.withAlpha(200);
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: (value + index * 0.3) * 2 * 3.1416,
                        child: SizedBox(
                          width: 50 + index * 25.0,
                          height: 50 + index * 25.0,
                          child: CircularProgressIndicator(
                            color: color,
                            strokeWidth: 8 - index * 2.0,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
    };
  }
}
