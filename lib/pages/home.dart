
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/pages/widgets/large_app_bar.dart';
import 'package:self_help/providers/page_route_provider.dart';
import 'package:self_help/theme.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowController = ref.read(pageRouteProvider);

    return Scaffold(
      appBar: LargeAppBar(),
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
              SizedBox(
                height: 150,
                width: 150,
                child: FloatingActionButton.large(
                  // backgroundColor: mintGreen,
                  shape: CircleBorder(),
                  foregroundColor: Colors.grey,
                  onPressed: () {
                    flowController.startFlow(1);
                    Navigator.pushNamed(context, flowController.currentRoute);
                  },
                  heroTag: 'exercise1',
                  child: Text(
                    'התחל תרגול',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
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
        // color: mintGreen,
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
