import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants.dart';
import 'package:self_help/core/flow_route_constant.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_route_provider.dart';
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
  final void Function()? cb;

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
          cb: () {
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
      AppBarType.sos => AppBarContent._sos(
          screenHeight: screenHeight,
          topPadding: topPadding,
          collapsedPanelHeight: collapsedPanelHeight,
          localizations: localizations,
          cb: () {
            final provider = ref.read(pageFlowProvider.notifier);
            provider.startFlow(FlowType.sos);
          }),
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
    this.cb,
  });

  factory AppBarContent.hidden() => const AppBarContent._();

  factory AppBarContent._welcome({
    required double screenHeight,
    required AppLocalizations localizations,
    void Function()? cb,
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
        cb: cb,
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
    void Function()? cb,
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
        cb: cb,
      );
}
