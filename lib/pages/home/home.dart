import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/extensions/date_extensions.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/models/diary_thought.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/home/widgets/home_card.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/services.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider).value;
    final title = localizations.welcomeMessage(user?.displayName ?? 'Guest');
    final subtitle = localizations.welcomeSubtitle;

    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.home,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardSosDescription,
                buttonTitle: localizations.startSosButtonTitle,
                imagePath: AssetsConstants.sosGirl,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.sosLanding.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardResilienceDescription,
                buttonTitle: localizations.startResilienceButtonTitle,
                imagePath: AssetsConstants.confidenceMan,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.resilience.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardTherapistDescription,
                buttonTitle: localizations.startFindATherapistButtonTitle,
                imagePath: AssetsConstants.therapist,
                onPressed: () {
                  // TODO:
                },
              ),

              // GradientFilledButton(onPressed: () {}, title: 'title'),
              // SizedBox(height: 16),
              // GradientElevatedButton(onPressed: () {}, title: 'title'),
              // SizedBox(height: 16),
              // GradientOutlinedButton(onPressed: () {}, title: 'title'),
            ],
          ),
        ],
      ),
    );
  }
}
