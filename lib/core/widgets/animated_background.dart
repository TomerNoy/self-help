import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      colors: const [
        Color(0xFFEDDBC5),
        Color(0xFFEDBFF3),
        Color(0xFFE7BBCD),
        Color(0xFFEFDDFD),
      ],
      options: AnimatedMeshGradientOptions(
        speed: 2,
        amplitude: 5,
        frequency: 4,
      ),
    );
  }
}
