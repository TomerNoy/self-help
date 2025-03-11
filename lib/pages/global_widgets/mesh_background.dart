// import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';
// import 'package:mesh_gradient/mesh_gradient.dart';

class MeshBackground extends StatefulWidget {
  const MeshBackground({super.key});

  static const colors = ["002F6C", "569BF2", "F2F2F2", "F2F2F2"];

  @override
  State<MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends State<MeshBackground>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: OMeshGradient(
        mesh: OMeshRect(
          width: 3,
          height: 4,
          fallbackColor: Color(0xffffffff),
          backgroundColor: Color(0xffffffff),
          vertices: [
            (-0.06, 0.03).v.bezier(
                  east: (0.01, 0.2).v,
                  south: (-0.05, 0.22).v,
                ),
            (0.49, 0.51).v.bezier(
                  east: (0.7, 0.52).v,
                  south: (0.56, 0.52).v,
                  west: (0.27, 0.46).v,
                ),
            (1.15, 0.23).v.bezier(
                  west: (1.02, 0.29).v,
                ), // Row 1
            (-0.14, 0.47).v.bezier(
                  north: (-0.15, 0.23).v,
                  east: (0.13, 0.51).v,
                ),
            (0.49, 0.55).v.bezier(
                  north: (0.51, 0.55).v,
                  east: (0.7, 0.56).v,
                  west: (0.26, 0.53).v,
                ),
            (1.16, 0.37).v.bezier(
                  west: (1.04, 0.48).v,
                ), // Row 2
            (-0.05, 0.62).v.bezier(
                  east: (0.1, 0.59).v,
                  south: (-0.19, 0.66).v,
                ),
            (0.49, 0.62).v.bezier(
                  east: (0.66, 0.62).v,
                  south: (0.54, 0.71).v,
                  west: (0.38, 0.61).v,
                ),
            (1.1, 0.6).v.bezier(
                  north: (1.13, 0.53).v,
                  south: (1.02, 0.84).v,
                  west: (0.87, 0.64).v,
                ), // Row 3
            (-0.0, 1.11).v.bezier(
                  north: (-0.28, 0.79).v,
                  east: (0.18, 1.06).v,
                ),
            (0.53, 1.08).v.bezier(
                  north: (0.56, 0.66).v,
                  east: (0.74, 1.11).v,
                  west: (0.41, 1.07).v,
                ),
            (1.11, 1.11).v.bezier(
                  north: (1.04, 0.89).v,
                  west: (1.04, 1.09).v,
                ), // Row 4
          ],
          colors: const [
            Color(0xffffffff), Color(0xffffffff), Color(0xffffffff), // Row 1
            Color(0xffd5e3ff), Color(0xffffdad6), Color(0xffffdad6), // Row 2
            Color(0xffc4c6cf), Color(0xffc4c6cf), Color(0xffc4c6cf), // Row 3
            Color(0xffffffff), Color(0xffffffff), Color(0xffffffff), // Row 4
          ],
        ),
      ),
    );
  }
}
