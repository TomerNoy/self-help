import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      colors: const [
        // Color(0xFFFB8500),
        Color.fromARGB(255, 124, 202, 240),
        Color.fromARGB(255, 214, 255, 254),
        Color.fromARGB(255, 189, 245, 255),
        Color.fromARGB(255, 173, 243, 245),
        // Color(0xFFADB5BD),
        // Color(0xFFDEE2E6),
        // Color(0xFFF8F9FA),
        // Color(0xFFCED4DA),
      ],
      options: AnimatedMeshGradientOptions(
        speed: 2,
        amplitude: 4,
        frequency: 4,
      ),
    );
  }
}
