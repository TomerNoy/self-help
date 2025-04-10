import 'package:flutter/material.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
    required this.page,
  });

  final Widget child;
  final RoutePaths? page;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBackground(page: page),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            drawer: FlowDrawer(),
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
