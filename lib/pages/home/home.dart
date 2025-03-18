import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';
import 'package:self_help/pages/home/widgets/home_card.dart';
import 'package:self_help/services/services.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider).value;
    final title = localizations.welcomeMessage(user?.displayName ?? 'Guest');
    final subtitle = localizations.welcomeSubtitle;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {

          appbarNotifier.updateState(
            appBarType: AppBarType.expanded,
            appBarTitle: title,
            subtitle: subtitle,
          );
        },
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.home) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);



    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              HomeCard(
                // backgroundColor: whiteGrey,
                description: 'פרוטוקול להתמודדות עם לחץ/חרדה',
                buttonTitle: localizations.startSosButtonTitle,
                imagePath: AssetsConstants.sosGirl,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.sosLanding.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: 'בנה את החוסן הנפשי שלך - תרגול יום יומי',
                buttonTitle: localizations.startResilienceButtonTitle,
                imagePath: AssetsConstants.confidenceMan,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.resilience.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: 'מצא מטפל קרוב אליך',
                buttonTitle: localizations.startFindATherapistButtonTitle,
                imagePath: AssetsConstants.therapist,
                onPressed: () {
                  // todo
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
