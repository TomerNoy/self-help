import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/services/services.dart';

class AppBarContent {
  final String title;
  final String subtitle;
  final String buttonTitle;
  final double logoHeight;
  final double subtitleHeight;
  final double buttonHeight;
  final double animationHeight;
  final double opacity;
  final void Function()? startPressed;
  final void Function()? backPressed;

  factory AppBarContent({
    required BuildContext context,
    required AppBarType state,
    required WidgetRef ref,
  }) {
    if (state == AppBarType.hidden) return AppBarContent.hidden();

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final topPadding = mediaQuery.padding.top;
    final collapsedPanelHeight = Constants.collapsedAppBarHeight + topPadding;
    final localizations = AppLocalizations.of(context)!;

    loggerService.debug('AppBarContent: state: $state');

    return switch (state) {
      AppBarType.welcome => AppBarContent._welcome(
          screenHeight: screenHeight,
          localizations: localizations,
          startPressed: () {
            ref
                .read(collapsingAppBarProvider.notifier)
                .updateState(AppBarType.login);
            storageService.writeRouterProviderWasInit(true);
          },
        ),
      AppBarType.login => AppBarContent._login(
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
        ),
      AppBarType.register => AppBarContent._register(
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
        ),
      AppBarType.home => AppBarContent._home(
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          ref: ref,
        ),
      AppBarType.profile => AppBarContent._profile(
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          backPressed: () {
            ref
              ..read(collapsingAppBarProvider.notifier)
                  .updateState(AppBarType.home)
              ..read(routerStateProvider).goNamed(RoutePaths.home.name);
          },
        ),
      AppBarType.settings => AppBarContent._settings(
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          backPressed: () {
            ref
              ..read(collapsingAppBarProvider.notifier)
                  .updateState(AppBarType.home)
              ..read(routerStateProvider).goNamed(RoutePaths.home.name);
          },
        ),
      AppBarType.sos => AppBarContent._sos(
          screenHeight: screenHeight,
          topPadding: topPadding,
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          startPressed: () {
            final provider = ref.read(pageFlowProvider.notifier);
            provider.startFlow(FlowType.sos);
          },
          backPressed: () {
            ref
                .read(collapsingAppBarProvider.notifier)
                .updateState(AppBarType.home);
          },
        ),
      AppBarType.gainControl => AppBarContent._gainControl(
          screenHeight: screenHeight,
          topPadding: topPadding,
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          startPressed: () {
            final provider = ref.read(pageFlowProvider.notifier);
            provider.startFlow(FlowType.gainControl);
          },
          backPressed: () {
            ref
                .read(collapsingAppBarProvider.notifier)
                .updateState(AppBarType.home);
          },
        ),
      _ => AppBarContent.hidden(),
    };
  }
  const AppBarContent._({
    this.title = '',
    this.subtitle = '',
    this.buttonTitle = '',
    this.logoHeight = 0.0,
    this.subtitleHeight = 0.0,
    this.buttonHeight = 0.0,
    this.animationHeight = 0.0,
    this.opacity = 0.0,
    this.startPressed,
    this.backPressed,
  });

  factory AppBarContent.hidden() => const AppBarContent._();

  factory AppBarContent._welcome({
    required double screenHeight,
    required AppLocalizations localizations,
    void Function()? startPressed,
  }) =>
      AppBarContent._(
        title: localizations.welcomeTitle,
        subtitle: localizations.welcomeSubtitle,
        buttonTitle: localizations.welcomeButtonTitle,
        logoHeight: 154.0,
        subtitleHeight: 70.0,
        buttonHeight: 150.0,
        animationHeight: screenHeight,
        opacity: 1.0,
        startPressed: startPressed,
      );

  factory AppBarContent._login({
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
  }) =>
      AppBarContent._(
        title: localizations.login,
        logoHeight: 70.0,
        animationHeight: collapsedPanelHeight,
        opacity: 1.0,
      );

  factory AppBarContent._register({
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
  }) =>
      AppBarContent._(
        title: localizations.register,
        logoHeight: 70.0,
        animationHeight: collapsedPanelHeight,
        opacity: 1.0,
      );

  factory AppBarContent._profile({
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
    void Function()? backPressed,
  }) =>
      AppBarContent._(
        title: 'Profile',
        logoHeight: 70.0,
        animationHeight: collapsedPanelHeight,
        opacity: 1.0,
        backPressed: backPressed,
      );

  factory AppBarContent._settings({
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
    void Function()? backPressed,
  }) =>
      AppBarContent._(
        title: 'Settings',
        logoHeight: 70.0,
        animationHeight: collapsedPanelHeight,
        opacity: 1.0,
        backPressed: backPressed,
      );

  factory AppBarContent._home({
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
    required WidgetRef ref,
  }) =>
      AppBarContent._(
        title: localizations.welcomeMessage(
            ref.watch(userProvider).valueOrNull?.displayName ?? ''),
        subtitle: localizations.homeSubtitle,
        subtitleHeight: 45.0,
        animationHeight: collapsedPanelHeight,
        opacity: 1.0,
      );

  factory AppBarContent._sos({
    required double screenHeight,
    required double topPadding,
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
    void Function()? startPressed,
    void Function()? backPressed,
  }) =>
      AppBarContent._(
        title: localizations.sosMainTitle,
        subtitle: localizations.sosMainInfo,
        buttonTitle: localizations.startExercise,
        logoHeight: 70.0,
        subtitleHeight: 100.0,
        buttonHeight: 150.0,
        animationHeight: screenHeight,
        opacity: 1.0,
        startPressed: startPressed,
        backPressed: backPressed,
      );

  factory AppBarContent._gainControl({
    required double screenHeight,
    required double topPadding,
    required double collapsedPanelHeight,
    required AppLocalizations localizations,
    void Function()? startPressed,
    void Function()? backPressed,
  }) =>
      AppBarContent._(
        title: localizations.gainControlLandingTitle,
        subtitle: localizations.gainControlLandingSubtitle,
        buttonTitle: localizations.startExercise,
        logoHeight: 70.0,
        subtitleHeight: 100.0,
        buttonHeight: 150.0,
        animationHeight: screenHeight,
        opacity: 1.0,
        startPressed: startPressed,
        backPressed: backPressed,
      );
}
