import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/home/widgets/home_card.dart';
import 'package:self_help/pages/home/widgets/home_route.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/services/services.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final topPadding = MediaQuery.of(context).padding.top;
    final appBarHeight = Constants.collapsedAppBarHeight;
    final pageStartFrom = appBarHeight + topPadding + 16;

    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          loggerService.debug('didPop: $didPop, result: $result');
          if (ref.read(collapsingAppBarProvider) != AppBarType.home) {
            ref
                .read(collapsingAppBarProvider.notifier)
                .updateState(AppBarType.home);
          }
        },
        canPop: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: pageStartFrom,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeRoute(
                    label: 'פרופיל',
                    icon: Icons.person,
                    onPressed: () {
                      final provider = ref.read(routerStateProvider);
                      provider.pushNamed(RoutePaths.profile.name);
                    },
                  ),
                  HomeRoute(
                    label: 'הגדרות',
                    icon: Icons.settings,
                    onPressed: () {
                      final provider = ref.read(routerStateProvider);
                      provider.pushNamed(RoutePaths.settings.name);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              HomeCard(
                backgroundColor: greyBackgroundColor,
                description: 'פרוטוקול להתמודדות עם לחץ/חרדה',
                buttonTitle: localizations.startSosButtonTitle,
                imagePath: AssetsConstants.sosGirl,
                onPressed: () {
                  ref
                      .read(collapsingAppBarProvider.notifier)
                      .updateState(AppBarType.sos);
                },
              ),
              HomeCard(
                backgroundColor: greyBackgroundColor,
                description: 'בנה את החוסן הנפשי שלך - תרגול יום יומי',
                buttonTitle: localizations.startResilienceButtonTitle,
                imagePath: AssetsConstants.confidenceMan,
                onPressed: () {
                  ref
                      .read(collapsingAppBarProvider.notifier)
                      .updateState(AppBarType.sos);
                },
              ),
              HomeCard(
                backgroundColor: greyBackgroundColor,
                description: 'מצא מטפל קרוב אליך',
                buttonTitle: localizations.startFindATherapistButtonTitle,
                imagePath: AssetsConstants.therapist,
                onPressed: () {
                  ref
                      .read(collapsingAppBarProvider.notifier)
                      .updateState(AppBarType.sos);
                },
              ),
              IconButton(
                onPressed: () async => await userService.signOut(),
                icon: Icon(Icons.build),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                icon: Icon(Icons.build),
              )
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SosLanding(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0); // Slide from top to bottom
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0); // Fade effect

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}
