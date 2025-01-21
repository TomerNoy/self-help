import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/constants.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.of(context).padding.top;
    final appBarHeight = Constants.collapsedAppBarHeight;
    final pageStartFrom = appBarHeight + topPadding + 16;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          top: pageStartFrom,
          left: 16,
          right: 16,
        ),
        children: [
          ListTile(
            title: const Text('_'),
            subtitle: Text('_'),
          ),
        ],
      ),
    );
  }
}
