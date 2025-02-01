import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
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
    final animatedPageKey = ValueKey('${page?.name}');
    final localizations = AppLocalizations.of(context)!;
    final animatedScreenPadding = const EdgeInsets.all(16);
    final animatiodDuration = Duration(milliseconds: 500);
    final expandedHeight = MediaQuery.of(context).size.height;

    final titleTheme = Theme.of(context).textTheme.headlineMedium;

    final hasAppBar = _hasAppBar();
    final hasSubtitles = _hasSubtitles();
    final hasLogo = _hasLogo();

    final animatedScreenType = _getAnimatedScreenType();
    final isExpanded = animatedScreenType == AnimatedScreenType.expanded;
    final animatedScreenHeight = _getAnimatedScreenHeight(
      animatedScreenType,
      expandedHeight,
    );

    final title = _getTitle(localizations, ref);
    final subtitle = _getSubtitle(localizations);

    final animatedScreenDecorations = BoxDecoration(
      borderRadius: animatedScreenType == AnimatedScreenType.collapsed
          ? BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )
          : null,
    );

    final titleWidget = Text(
      title,
      style: titleTheme,
      textAlign: TextAlign.center,
    );

    final logoWidget = Image.asset(
      AssetsConstants.selfHelpNoBk,
      height: page == RoutePaths.welcome ? 140.0 : 60.0,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                                _buildLogoWidget(hasAppBar, logoWidget, ref),

                              // title and subtitles
                              hasSubtitles
                                  ? _buildTitleAndSubtitleWidget(
                                      titleWidget,
                                      subtitle,
                                      isExpanded,
                                      ref,
                                      context,
                                    )
                                  : _buildTitleWidget(titleWidget),

                              // enter button
                              if (isExpanded) _buildButtonWidget(ref),
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
      ),
    );
  }

  bool _hasAppBar() {
    return [
      RoutePaths.sosLanding,
      RoutePaths.gainControlLanding,
      RoutePaths.profile,
      RoutePaths.settings,
    ].contains(page);
  }

  bool _hasSubtitles() {
    return [
      RoutePaths.welcome,
      RoutePaths.home,
      RoutePaths.sosLanding,
    ].contains(page);
  }

  bool _hasLogo() {
    return [
      RoutePaths.welcome,
      RoutePaths.sosLanding,
      RoutePaths.login,
      RoutePaths.register,
      RoutePaths.profile,
      RoutePaths.settings,
      RoutePaths.gainControlLanding,
    ].contains(page);
  }

  AnimatedScreenType _getAnimatedScreenType() {
    return switch (page) {
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
  }

  String _getTitle(
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return switch (page) {
      RoutePaths.login => localizations.login,
      RoutePaths.register => localizations.registering,
      RoutePaths.welcome => localizations.welcomeTitle,
      RoutePaths.sosLanding => localizations.sosMainTitle,
      RoutePaths.profile => localizations.profile,
      RoutePaths.settings => localizations.settings,
      RoutePaths.home => localizations.welcomeMessage(
          ref.watch(userProvider).valueOrNull?.displayName ?? ''),
      _ => ''
    };
  }

  double _getAnimatedScreenHeight(
    AnimatedScreenType animatedScreenType,
    double expandedHeight,
  ) {
    return switch (animatedScreenType) {
      AnimatedScreenType.expanded => expandedHeight,
      AnimatedScreenType.collapsed => 200.0,
      AnimatedScreenType.hidden => 0.0,
    };
  }

  String _getSubtitle(AppLocalizations localizations) {
    return switch (page) {
      RoutePaths.welcome => localizations.welcomeSubtitle,
      RoutePaths.profile => 'Profile',
      RoutePaths.home => localizations.homeSubtitle,
      RoutePaths.sosLanding => localizations.sosMainInfo,
      _ => ''
    };
  }

  Widget _buildLogoWidget(bool hasAppBar, Widget logoWidget, WidgetRef ref) {
    return Expanded(
      child: Center(
        child: hasAppBar
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.white30,
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(routerStateProvider)
                          .goNamed(RoutePaths.welcome.name);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  logoWidget,
                  SizedBox(width: 48),
                ],
              )
            : logoWidget,
      ),
    );
  }

  Widget _buildButtonWidget(WidgetRef ref) {
    return Expanded(
      child: Center(
        child: WideButton(
          title: '${page?.name}',
          onPressed: () {
            final provider = ref.read(pageFlowProvider.notifier);
            provider.startFlow(FlowType.sos);
          },
          type: ButtonType.transparent,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitleWidget(
    Text titleWidget,
    String subtitle,
    bool hasButton,
    WidgetRef ref,
    BuildContext context,
  ) {
    final subtitleTheme = Theme.of(context).textTheme.bodyMedium;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: titleWidget,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  subtitle,
                  style: subtitleTheme,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget(Widget titleWidget) {
    return Expanded(
      child: Center(
        child: titleWidget,
      ),
    );
  }
}
