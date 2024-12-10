import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/pages/widgets/animated_background.dart';

class Connecting extends ConsumerWidget {
  const Connecting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'welcome',
                child: AnimatedBackground(
                  height: 200,
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.seedling),
                          Text('התחברות...'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: SingleChildScrollView()),
              SizedBox(height: 16),
              Text('Connecting...'),
            ],
          ),
        ),
      ),
    );
  }
}
