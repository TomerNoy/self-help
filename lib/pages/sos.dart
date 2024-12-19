import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/widgets/animated_background.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/routes/router.dart';

class Sos extends ConsumerWidget {
  const Sos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final logo = SvgPicture.asset(
      'assets/icons/logo.svg',
      width: 70,
    );
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox.expand(
              child: AnimatedBackground(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                              ),
                            ),
                          ),
                        ),
                      ),
                      logo,
                      SizedBox(width: 70),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        localizations.step1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 24),
                      Text(
                        localizations.sosMainTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        localizations.sosMainInfo,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  WideButton(
                    title: localizations.startExercise,
                    onPressed: () => context.pushNamed(AppRoutes.measure),
                    type: ButtonType.gradient,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
