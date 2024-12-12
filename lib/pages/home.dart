import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/providers/user_provider.dart';
import 'package:self_help/core/widgets/animated_background.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/measure_level.dart';
import 'package:self_help/providers/page_route_provider.dart';
import 'package:self_help/services/services.dart';
import 'package:self_help/theme.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowController = ref.read(pageRouteProvider);

    final statusBarHeight = MediaQuery.of(context).padding.top;

    final topBarHeight =
        MediaQuery.of(context).size.height * 0.39 - statusBarHeight;

    final localizations = AppLocalizations.of(context)!;
    final userProvider = ref.watch(currentUserProvider);
    final userName = userProvider.value?.displayName ?? localizations.guest;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: topBarHeight,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: SizedBox.expand(
                    child: AnimatedBackground(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 50 + statusBarHeight,
                    left: 16,
                    right: 16,
                  ),
                  child: SizedBox.expand(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.welcomeMessage(userName),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          localizations.homeTitle,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: FloatingActionButton(
                      onPressed: () {},
                      shape: const CircleBorder(),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF79c3dd),
                              Color(0xFF6e79ed),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                            localizations.startSosButtonTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await userService.signOut();
                      },
                      icon: Icon(Icons.build)),
                ],
              ),
            ),
          ),
        ],
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
