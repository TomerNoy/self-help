import 'package:flutter/material.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: AnimatedBackground(),
          ),
          ...List.generate(3, (index) {
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
    );
  }
}
