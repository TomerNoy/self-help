import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/core/strings.dart';
import 'package:self_help/pages/drag_cloud.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Help'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Popup Title'),
                    content: const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(Strings.test),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const FaIcon(FontAwesomeIcons.circleExclamation),
          ),
        ],
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Breathing(),
                    ),
                  );
                },
                child: const Text('breathing test'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeasureLevel(),
                    ),
                  );
                },
                child: const Text('gauge test'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DraggableItemDemo(),
                    ),
                  );
                },
                child: const Text('cloud test'),
              ),
              // const SizedBox(height: 30),
              // const LargeButton(title: 'תרגול למקרה חירום'),
              // const SizedBox(height: 30),
              // const LargeButton(title: 'תרגול חוסן פנימי'),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: mintGreen,
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeasureLevel(),
            ),
          );
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
