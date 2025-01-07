import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/pages/global_providers/page_route_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class GainControlLanding extends ConsumerWidget {
  const GainControlLanding({super.key});

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
                              onPressed: () {
                                final provider =
                                    ref.read(pageFlowProvider.notifier);
                                provider.back();
                              },
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
                        localizations.step2,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 24),
                      Text(
                        localizations.gainControlLandingTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        localizations.gainControlLandingSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  WideButton(
                    title: localizations.letsContinueButtonTitle,
                    onPressed: () {
                      final provider = ref.read(pageFlowProvider.notifier);
                      provider.next();
                    },
                    type: ButtonType.transparent,
                    width: double.infinity,
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
