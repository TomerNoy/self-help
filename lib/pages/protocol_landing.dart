import 'package:flutter/material.dart';
import 'package:self_help/pages/breathing.dart';
import 'package:self_help/pages/drag_cloud.dart';
import 'package:self_help/pages/measure_level.dart';

class ProtocolLanding extends StatelessWidget {
  const ProtocolLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protocol Landing'),
      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'פרוטוקול לטיפול עצמי\nהתמודדות עם לחץ וחרדה',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              FloatingActionButton.large(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Breathing(),
                    ),
                  );
                },
                heroTag: 'breathing',
                child: const Text('breathing'),
              ),
              const SizedBox(height: 30),
              FloatingActionButton.large(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeasureLevel(),
                    ),
                  );
                },
                heroTag: 'gauge',
                child: const Text('gauge'),
              ),
              const SizedBox(height: 30),
              FloatingActionButton.large(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DraggableItemDemo(),
                    ),
                  );
                },
                heroTag: 'cloud',
                child: const Text('cloud'),
              ),
              // const SizedBox(height: 30),
              // const LargeButton(title: 'תרגול למקרה חירום'),
              // const SizedBox(height: 30),
              // const LargeButton(title: 'תרגול חוסן פנימי'),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
