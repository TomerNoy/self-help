import 'package:flutter/material.dart';
import 'package:self_help/core/theme.dart';
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
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              whiteGrey,
              white,
              whiteGrey,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CollapsingAppbar(
            size: MediaQuery.of(context).size,
          ),
          body: child,
        ),
      ),
    );
  }
}
