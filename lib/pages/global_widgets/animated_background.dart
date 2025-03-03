import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:self_help/core/theme.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  static const colors = ["002F6C", "569BF2", "F2F2F2", "F2F2F2"];

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      colors: [
        whiteGrey,
        blue,
        blue2,
        blue3,
      ],
      options: AnimatedMeshGradientOptions(
        speed: 4,
        amplitude: 4,
        frequency: 4,
      ),
    );
  }
}
