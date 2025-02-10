import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/services/services.dart';

enum AnimatedScreenType { expanded, collapsedLong, collapsedShort, hidden }

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

    final animatedScreenType = switch (page) {
      // expanded
      RoutePaths.welcome ||
      RoutePaths.sosLanding ||
      RoutePaths.gainControlLanding =>
        AnimatedScreenType.expanded,
      // collapsed long
      RoutePaths.home => AnimatedScreenType.collapsedLong,
      // collapsed short
      RoutePaths.login ||
      RoutePaths.register ||
      RoutePaths.settings ||
      RoutePaths.profile =>
        AnimatedScreenType.collapsedShort,
      // hidden
      _ => AnimatedScreenType.hidden,
    };

    final animatedScreenHeight = switch (animatedScreenType) {
      AnimatedScreenType.expanded => MediaQuery.of(context).size.height,
      AnimatedScreenType.collapsedLong => 200.0,
      AnimatedScreenType.collapsedShort => 150.0,
      AnimatedScreenType.hidden => 0.0,
    };

    final animatedScreenDecoration = BoxDecoration(
      borderRadius: [
        AnimatedScreenType.collapsedLong,
        AnimatedScreenType.collapsedShort
      ].contains(animatedScreenType)
          ? BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )
          : null,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            // animated screen
            AnimatedContainer(
              clipBehavior: Clip.antiAlias,
              height: animatedScreenHeight,
              duration: Constants.animatiodDuration,
              decoration: animatedScreenDecoration,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: const AnimatedBackground(),
                  ),
                  // animated screen content
                  SafeArea(
                    child: AnimatedSwitcher(
                      duration: Constants.animatiodDuration,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          // key: ValueKey('${page?.name}'),
                          opacity: animation,
                          child: child,
                        );
                      },
                      // sizeed box used only for the key
                      child: SizedBox(
                        key: ValueKey('${page?.name}'),
                        child: switch (animatedScreenType) {
                          AnimatedScreenType.hidden => const SizedBox.shrink(),
                          _ => _buildVisibleAnimatedScreenContent(
                              context,
                              ref,
                              animatedScreenType,
                            ),
                        },
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

  void _startPressed(WidgetRef ref) {
    if (page == RoutePaths.welcome) {
      final provider = ref.read(routerStateProvider);
      provider.pushNamed(RoutePaths.login.name);
    } else {
      final provider = ref.read(pageFlowProvider.notifier);
      provider.startFlow(FlowType.sos);
    }
  }

  void _backPressed(WidgetRef ref) {
    ref.read(routerStateProvider).goNamed(RoutePaths.welcome.name);
  }

  Widget _buildTitleWidget(
    BuildContext context,
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return Text(
      switch (page) {
        RoutePaths.login => localizations.login,
        RoutePaths.register => localizations.registering,
        RoutePaths.welcome => localizations.welcomeTitle,
        RoutePaths.sosLanding => localizations.sosMainTitle,
        RoutePaths.profile => localizations.profile,
        RoutePaths.settings => localizations.settings,
        RoutePaths.home => localizations.welcomeMessage(
            ref.read(userProvider).valueOrNull?.displayName ?? ''),
        _ => ''
      },
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildVisibleAnimatedScreenContent(
    BuildContext context,
    WidgetRef ref,
    AnimatedScreenType animatedScreenType,
  ) {
    final localizations = AppLocalizations.of(context)!;

    final titleWidget = _buildTitleWidget(context, localizations, ref);

    final menuButton = _buildMenuButton(ref);

    final hasBackButton = [
      RoutePaths.sosLanding,
    ].contains(page);

    final hasLogo = [
      RoutePaths.welcome,
    ].contains(page);

    final hasSubtitle = [
      RoutePaths.welcome,
      RoutePaths.home,
      RoutePaths.sosLanding,
    ].contains(page);

    final hasStartButton = [
      RoutePaths.welcome,
      RoutePaths.sosLanding,
    ].contains(page);

    final isExpanded = animatedScreenType == AnimatedScreenType.expanded;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (hasBackButton) _buildBackButton(ref),
            if (hasLogo) _buildLogo(),
            hasSubtitle
                ? _buildTitltWithSubtitle(
                    context,
                    titleWidget,
                    localizations,
                    menuButton,
                    isExpanded,
                  )
                : _buildTitle(titleWidget, menuButton),
            if (hasStartButton) _buildStartButton(localizations, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(WidgetRef ref) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton.filled(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.white30,
              ),
            ),
            onPressed: () => _backPressed(ref),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Expanded(
      child: Center(
        child: Image.asset(
          AssetsConstants.selfHelpNoBk,
          height: page == RoutePaths.welcome ? 140.0 : 60.0,
        ),
      ),
    );
  }

  Widget _buildTitltWithSubtitle(
    BuildContext context,
    Widget titleWidget,
    AppLocalizations localizations,
    Widget menuButton,
    bool isExpanded,
  ) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: isExpanded
                    ? titleWidget
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          menuButton,
                          Expanded(child: titleWidget),
                          SizedBox(width: 40),
                        ],
                      ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  switch (page) {
                    RoutePaths.welcome => localizations.welcomeSubtitle,
                    RoutePaths.profile => localizations.profile,
                    RoutePaths.home => localizations.homeSubtitle,
                    RoutePaths.sosLanding => localizations.sosMainInfo,
                    _ => ''
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(Widget titleWidget, Widget menuButton) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          menuButton,
          titleWidget,
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildStartButton(
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return Expanded(
      child: Center(
        child: WideButton(
          title: switch (page) {
            RoutePaths.welcome => localizations.welcomeButtonTitle,
            RoutePaths.sosLanding => localizations.startExercise,
            _ => ''
          },
          onPressed: () => _startPressed(ref),
          type: ButtonType.transparent,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildMenuButton(WidgetRef ref) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton.filled(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white30,
            ),
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        );
      },
      menuChildren: List.generate(
        10,
        (index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    );
  }
}
