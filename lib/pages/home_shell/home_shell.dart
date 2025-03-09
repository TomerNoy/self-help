import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class HomeShell extends HookConsumerWidget {
  const HomeShell({
    super.key,
    required this.child,
    required this.page,
  });

  final Widget child;
  final RoutePaths? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final profileButtonIsExpanded = page == RoutePaths.profile;
    final settingsButtonIsExpanded = page == RoutePaths.settings;
    final homeButtonIsExpanded = page == RoutePaths.home;

    final notchMarginController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final notchMarginAnimation = Tween<double>(begin: 3, end: 8).animate(
      CurvedAnimation(parent: notchMarginController, curve: Curves.easeInOut),
    );

    homeButtonIsExpanded
        ? notchMarginController.forward()
        : notchMarginController.reverse();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: child,
      bottomNavigationBar: AnimatedBuilder(
        animation: notchMarginAnimation,
        builder: (context, child) {
          return BottomAppBar(
            padding: const EdgeInsets.all(0),
            height: 60,
            shape: const CircularNotchedRectangle(),
            notchMargin: notchMarginAnimation.value,
            color: blue,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedIconButton(
                      iconData: Icons.person,
                      label: localizations.profile,
                      onPressed: () {
                        final provider = ref.read(routerStateProvider);
                        provider.pushNamed(RoutePaths.profile.name);
                      },
                      isExpanded: profileButtonIsExpanded,
                    ),
                    AnimatedIconButton(
                      label: localizations.settings,
                      iconData: Icons.settings,
                      onPressed: () {
                        final provider = ref.read(routerStateProvider);
                        provider.pushNamed(RoutePaths.settings.name);
                      },
                      isExpanded: settingsButtonIsExpanded,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: AnimatedFAB(isExpanded: homeButtonIsExpanded),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AnimatedIconButton extends HookWidget {
  const AnimatedIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.isExpanded,
    required this.label,
  });

  final IconData iconData;
  final VoidCallback onPressed;
  final bool isExpanded;
  final String label;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    isExpanded ? animationController.forward() : animationController.reverse();

    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
        iconColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: onPressed,
      icon: ScaleTransition(
        scale: scaleAnimation,
        child: Icon(iconData, size: 24),
      ),
      label: Text(label),
    );
  }
}

class AnimatedFAB extends HookConsumerWidget {
  const AnimatedFAB({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    isExpanded ? animationController.forward() : animationController.reverse();

    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blue,
              // purple,
              darkGrey,
            ],
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            final provider = ref.read(routerStateProvider);
            provider.pushNamed(RoutePaths.home.name);
          },
        ),
      ),
    );
  }
}
