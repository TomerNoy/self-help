import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class CollapsingAppbar extends ConsumerWidget {
  const CollapsingAppbar({super.key});

  static const animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarState = ref.watch(collapsingAppBarProvider);
    final logo = SvgPicture.asset('assets/icons/logo.svg');
    final localizations = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final collapsedPanelHeight = 150.0 + topPadding;

    // 51.80952380952381

    final opacity = switch (appBarState) {
      AppBarState.expanded => 1.0,
      AppBarState.collapsed => 0.0,
      AppBarState.hidden => 0.0,
    };

    final logoHeight = switch (appBarState) {
      AppBarState.expanded => 154.0,
      AppBarState.collapsed => 70.0,
      AppBarState.hidden => 0.0,
    };

    final titleHeight = switch (appBarState) {
      AppBarState.expanded => 70.0,
      AppBarState.collapsed => 0.0,
      AppBarState.hidden => 0.0,
    };

    final buttonHeight = switch (appBarState) {
      AppBarState.expanded => 150.0,
      AppBarState.collapsed => 0.0,
      AppBarState.hidden => 0.0,
    };

    final animationHeight = switch (appBarState) {
      AppBarState.expanded => screenHeight,
      AppBarState.collapsed => collapsedPanelHeight,
      AppBarState.hidden => 0.0,
    };

    return appBarState == AppBarState.hidden
        ? const SizedBox.shrink()
        : AnimatedContainer(
            duration: animationDuration,
            width: double.infinity,
            height: animationHeight,
            child: TweenAnimationBuilder<BorderRadius>(
              duration: animationDuration,
              curve: Curves.easeInOut,
              tween: Tween(
                begin: BorderRadius.vertical(
                    bottom: Radius.circular(
                        appBarState == AppBarState.expanded ? 50 : 0)),
                end: BorderRadius.vertical(
                    bottom: Radius.circular(
                        appBarState == AppBarState.expanded ? 0 : 50)),
              ),
              builder: (context, radius, child) {
                return ClipRRect(
                  borderRadius: radius,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: const AnimatedBackground(),
                      ),
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // logo
                                SafeArea(
                                  bottom: false,
                                  child: AnimatedContainer(
                                    duration: animationDuration,
                                    height: logoHeight,
                                    child: FittedBox(child: logo),
                                  ),
                                ),

                                // title
                                Column(
                                  children: [
                                    AnimatedSwitcher(
                                      duration: animationDuration,
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        key: ValueKey(appBarState),
                                        appBarState == AppBarState.expanded
                                            ? localizations.welcomeTitle
                                            : localizations.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    AnimatedContainer(
                                      duration: animationDuration,
                                      height: titleHeight,
                                      child: AnimatedOpacity(
                                        duration: animationDuration,
                                        opacity: opacity,
                                        child: Text(
                                          localizations.welcomeSubtitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // button
                                AnimatedContainer(
                                  duration: animationDuration,
                                  height: buttonHeight,
                                  child: AnimatedOpacity(
                                    duration: animationDuration,
                                    opacity: opacity,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: WideButton(
                                        onPressed: () => ref
                                            .read(collapsingAppBarProvider
                                                .notifier)
                                            .state = AppBarState.collapsed,
                                        title: localizations.welcomeButtonTitle,
                                        type: ButtonType.transparent,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
