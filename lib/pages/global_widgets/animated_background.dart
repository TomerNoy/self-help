import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});
  // static const colors = ["f1faee", "d3edee", "d1def0", "b8d1e0"];
  // static const colors = ["ccd5ae", "ebf0d1", "fefae0", "fdf8ec"];
  // static const colors = ["f3f4f6", "e5eaf1", "d5e8eb", "ced3de"];

  // keep
  // colors: [
  // Color(0xfff5f5f5),
  // Color(0xffb3dcf0),
  // Color(0xff91d1f0),
  // Color(0xff7fccee),
  // ],

  static const colors = ["002F6C", "569BF2", "F2F2F2", "F2F2F2"];

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      // colors: List.generate(
      //   4,
      //   (index) {
      //     return Color(int.parse('0xff${colors[index]}'));
      //   },
      // ),

      // keep
      colors: [
        Color(0xfff5f5f5),
        Color(0xffb3dcf0),
        Color(0xff91d1f0),
        Color(0xff7fccee),
      ],
      options: AnimatedMeshGradientOptions(
        speed: 4,
        amplitude: 4,
        frequency: 4,
      ),
    );
  }
}

// colors: [
//   Color(0xfff5f5f5),
//   Color(0xffb3dcf0),
//   Color(0xff91d1f0),
//   Color(0xff7fccee),
// ],

// const [
//   // Color(0xFFFB8500),
//
//   // Color.fromARGB(255, 173, 243, 245),
//   // Color.fromARGB(255, 214, 255, 254),
//   // Color.fromARGB(255, 184, 171, 246),
//   // Color.fromARGB(255, 247, 236, 251),
//
//   // same colors with hex:
//
//   Color(0xffFFEBFF),
//   Color(0xffEDD6FF),
//   Color(0xffE0D6FF),
//   Color(0xffbdc4f4),
//
//   // Color(0xFFADB5BD),
//   // Color(0xFFDEE2E6),
//   // Color(0xFFF8F9FA),
//   // Color(0xFFCED4DA),
// ],
