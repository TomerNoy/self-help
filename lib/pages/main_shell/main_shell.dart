import 'package:flutter/material.dart';
// import 'package:self_help/pages/global_widgets/abstract_animation.dart';
import 'package:self_help/pages/global_widgets/mesh_background.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar.dart';
import 'package:self_help/services/services.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    loggerService.debug('building main shell');
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Positioned.fill(
            child: MeshBackground(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CollapsingAppbar(
              size: MediaQuery.of(context).size,
            ),
            body: child,
          ),
        ],
      ),
    );
  }
}
