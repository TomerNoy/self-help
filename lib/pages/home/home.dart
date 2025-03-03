import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/home/widgets/home_card.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final routerListener = ref.watch(routerListenerProvider);
    final user = ref.watch(userProvider).value;

    if (routerListener == RoutePaths.home) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(animatedAppBarProvider.notifier).updateState(
              appBarType: AppBarType.expanded,
              appBarTitle:
                  localizations.welcomeMessage(user?.displayName ?? 'Guest'),
              subtitle: localizations.homeSubtitle,
            ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          HomeCard(
            backgroundColor: whiteGrey,
            description: 'פרוטוקול להתמודדות עם לחץ/חרדה',
            buttonTitle: localizations.startSosButtonTitle,
            imagePath: AssetsConstants.sosGirl,
            onPressed: () {
              final provider = ref.read(routerStateProvider);
              provider.pushNamed(RoutePaths.sosLanding.name);
            },
          ),
          HomeCard(
            backgroundColor: whiteGrey,
            description: 'בנה את החוסן הנפשי שלך - תרגול יום יומי',
            buttonTitle: localizations.startResilienceButtonTitle,
            imagePath: AssetsConstants.confidenceMan,
            onPressed: () {
              final provider = ref.read(routerStateProvider);
              provider.pushNamed(RoutePaths.resilience.name);
            },
          ),
          HomeCard(
            backgroundColor: whiteGrey,
            description: 'מצא מטפל קרוב אליך',
            buttonTitle: localizations.startFindATherapistButtonTitle,
            imagePath: AssetsConstants.therapist,
            onPressed: () {
              // todo
            },
          ),
        ],
      ),
    );
  }
}
