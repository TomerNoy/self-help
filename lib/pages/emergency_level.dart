import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/providers/level_provider.dart';
import 'package:self_help/theme.dart';

class EmergencyLevel extends ConsumerWidget {
  const EmergencyLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider.select((value) => value.state));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.circleExclamation),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 300,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Graph(),
                  const SizedBox(width: 30, child: Meter ()),
                  const SizedBox(width: 60),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$level',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          IconButton.filled(
                            iconSize: 40,
                            onPressed: () {
                              ref.read(levelProvider.notifier).increment();
                            },
                            icon: const Icon(Icons.arrow_upward),
                          ),
                          const SizedBox(height: 16),
                          IconButton.filled(
                            iconSize: 40,
                            onPressed: () {
                              ref.read(levelProvider.notifier).decrement();
                            },
                            icon: const Icon(Icons.arrow_downward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// right meter indicator
class Meter extends StatelessWidget {
  const Meter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          10,
          (index) {
            return Expanded(
              child: Level(title: (index + 1).toString()),
            );
          },
        ).reversed,
        const Expanded(child: Level(title: '0'))
      ],
    );
  }
}

/// left graph
class Graph extends ConsumerWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(levelProvider);

    return SizedBox(
      width: 30,
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          divisions: 10,
          value: provider.state.toDouble(),
          activeColor: Constants.redToGreenSteps[provider.state],
          // thumbColor: mintGreen,
          overlayColor: const WidgetStatePropertyAll(Colors.green),
          secondaryActiveColor: Colors.red,
          inactiveColor: Colors.black12,
          min: 0,
          max: 10,
          onChanged: (double v) {
            ref.read(levelProvider.notifier).state = v.toInt();
          },
        ),
      ),
    );
  }
}

class Level extends StatelessWidget {
  const Level({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(color: Colors.black12, height: 1)),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
