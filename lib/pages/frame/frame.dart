import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/services/services.dart';

enum AnimatedScreenType { expanded, collapsed, hidden }

class Frame extends ConsumerWidget {
  const Frame({
    super.key,
    required this.child,
    required this.page,
  });

  final Widget child;
  final RoutePaths? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggerService.info('page $page');

    final animatedScreenClipBehavior = Clip.antiAlias;

    final animatedScreenType = switch (page) {
      RoutePaths.welcome ||
      RoutePaths.sosLanding ||
      RoutePaths.gainControlLanding =>
        AnimatedScreenType.expanded,
      RoutePaths.login ||
      RoutePaths.register ||
      RoutePaths.home ||
      RoutePaths.settings ||
      RoutePaths.profile =>
        AnimatedScreenType.collapsed,
      _ => AnimatedScreenType.hidden,
    };

    final hasSubtitles = [
      RoutePaths.welcome,
      RoutePaths.home,
      RoutePaths.sosLanding
    ].contains(page);

    final hasLogo = [
      RoutePaths.welcome,
      RoutePaths.sosLanding,
      RoutePaths.login,
      RoutePaths.register,
      RoutePaths.gainControlLanding,
    ].contains(page);

    final expandedHeight = MediaQuery.of(context).size.height;
    final animatedScreenHeight = switch (animatedScreenType) {
      AnimatedScreenType.expanded => expandedHeight,
      AnimatedScreenType.collapsed => 200.0,
      AnimatedScreenType.hidden => 0.0,
    };

    final animatedPageKey = ValueKey('${page?.name}');
    final localizations = AppLocalizations.of(context)!;

    final title = switch (page) {
      RoutePaths.login => localizations.login,
      RoutePaths.register => localizations.registering,
      RoutePaths.welcome => localizations.welcomeTitle,
      RoutePaths.sosLanding => localizations.sosMainTitle,
      RoutePaths.profile => 'Profile',
      RoutePaths.home => localizations.welcomeMessage(
          ref.watch(userProvider).valueOrNull?.displayName ?? ''),
      _ => ''
    };

    final animatedScreenDecorations = BoxDecoration(
      borderRadius: animatedScreenType == AnimatedScreenType.expanded
          ? null
          : BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
    );

    final animatedScreenPadding = const EdgeInsets.symmetric(horizontal: 16);

    final subtitle = switch (page) {
      RoutePaths.welcome => localizations.welcomeSubtitle,
      RoutePaths.profile => 'Profile',
      RoutePaths.home => localizations.homeSubtitle,
      RoutePaths.sosLanding => localizations.sosMainInfo,
      _ => ''
    };

    final animatiodDuration = Duration(milliseconds: 500);

    final titleWidget = Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );

    return Scaffold(
      body: Column(
        children: [
          // animated screen
          AnimatedContainer(
            clipBehavior: animatedScreenClipBehavior,
            height: animatedScreenHeight,
            duration: animatiodDuration,
            decoration: animatedScreenDecorations,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: const AnimatedBackground(),
                ),
                // animated screen content
                SafeArea(
                  child: AnimatedSwitcher(
                    duration: animatiodDuration,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Center(
                      key: animatedPageKey,
                      child: Padding(
                        padding: animatedScreenPadding,
                        child: Column(
                          children: [
                            // logo
                            if (hasLogo)
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    AssetsConstants.selfHelpNoBk,
                                    height: page == RoutePaths.welcome
                                        ? 140.0
                                        : 60.0,
                                  ),
                                ),
                              ),

                            hasSubtitles
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        // title with subtitle
                                        Expanded(
                                          child: Align(
                                            alignment: hasSubtitles
                                                ? Alignment.bottomCenter
                                                : Alignment.center,
                                            child: titleWidget,
                                          ),
                                        ),

                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                subtitle,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                // title alone
                                : Expanded(
                                    child: Center(
                                      child: titleWidget,
                                    ),
                                  ),

                            // enter button
                            if (animatedScreenType ==
                                AnimatedScreenType.expanded)
                              Expanded(
                                child: Center(
                                  child: WideButton(
                                    title: '${page?.name}',
                                    onPressed: () {
                                      ref
                                          .read(routerStateProvider)
                                          .goNamed(RoutePaths.login.name);
                                    },
                                    type: ButtonType.transparent,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
