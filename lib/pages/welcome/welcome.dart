import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:self_help/core/widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/welcome/providers/is_expended_provider.dart';
import 'package:self_help/pages/welcome/widgets/login_form.dart';

class Welcome extends ConsumerWidget {
  const Welcome({super.key});

  static const scaleAnimationDuration = Duration(milliseconds: 500);
  static const fadeAnimationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isExpanded = ref.watch(isExpendedProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final collapsedPanelHeight = screenHeight * 0.39 - statusBarHeight;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: LoginForm(
              collapsedPanelHeight: collapsedPanelHeight,
            ),
          ),
          _buildExpandableContent(
            context,
            ref,
            localizations,
            isExpanded,
            screenHeight,
            collapsedPanelHeight,
          ),
          Positioned(
            bottom: 0,
            left: 30,
            child: IconButton(
              onPressed: () => ref.read(isExpendedProvider.notifier).toggle(),
              icon: const Icon(Icons.build),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableContent(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations localizations,
    bool isExpanded,
    double screenHeight,
    double collapsedPanelHeight,
  ) {
    final logo = SvgPicture.asset('assets/icons/logo.svg');

    return TweenAnimationBuilder<BorderRadius>(
      duration: scaleAnimationDuration,
      curve: Curves.easeInOut,
      tween: Tween(
        begin:
            BorderRadius.vertical(bottom: Radius.circular(isExpanded ? 50 : 0)),
        end:
            BorderRadius.vertical(bottom: Radius.circular(isExpanded ? 0 : 50)),
      ),
      builder: (context, radius, child) {
        return ClipRRect(
          borderRadius: radius,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildAnimatedBackground(
                context,
                isExpanded,
                screenHeight,
                collapsedPanelHeight,
              ),
              AnimatedContainer(
                duration: scaleAnimationDuration,
                height: isExpanded ? screenHeight : collapsedPanelHeight,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: scaleAnimationDuration,
                        height: isExpanded ? 154 : 70,
                        curve: Curves.easeInOut,
                        child: logo,
                      ),
                      AnimatedContainer(
                        duration: scaleAnimationDuration,
                        height: isExpanded ? screenHeight * 0.05 : 0,
                        curve: Curves.easeInOut,
                      ),
                      _buildAnimatedTitle(
                        localizations,
                        isExpanded,
                        context,
                      ),
                      AnimatedContainer(
                        duration: scaleAnimationDuration,
                        height: isExpanded ? 16 : 0,
                        curve: Curves.easeInOut,
                      ),
                      _buildAnimatedSubtitle(
                        localizations,
                        isExpanded,
                        context,
                      ),
                      AnimatedContainer(
                        duration: scaleAnimationDuration,
                        height: isExpanded ? screenHeight * 0.3 : 0,
                        curve: Curves.easeInOut,
                      ),
                      _buildAnimatedButton(
                        ref,
                        localizations,
                        isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedBackground(
    BuildContext context,
    bool isExpanded,
    double screenHeight,
    double collapsedPanelHeight,
  ) {
    return AnimatedContainer(
      duration: scaleAnimationDuration,
      height: isExpanded ? screenHeight : collapsedPanelHeight,
      width: MediaQuery.of(context).size.width,
      child: AnimatedMeshGradient(
        colors: const [
          Color(0xFFEDDBC5),
          Color(0xFFEDBFF3),
          Color(0xFFE7BBCD),
          Color(0xFFEFDDFD),
        ],
        options: AnimatedMeshGradientOptions(
          speed: 2,
          amplitude: 5,
          frequency: 4,
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle(
      AppLocalizations localizations, bool isExpanded, BuildContext context) {
    return AnimatedSwitcher(
      duration: scaleAnimationDuration,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Text(
        isExpanded ? localizations.welcomeTitle : localizations.login,
        key: ValueKey(isExpanded),
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnimatedSubtitle(
    AppLocalizations localizations,
    bool isExpanded,
    BuildContext context,
  ) {
    return AnimatedOpacity(
      duration: fadeAnimationDuration,
      opacity: isExpanded ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: scaleAnimationDuration,
        height: isExpanded ? 50 : 0,
        child: Text(
          localizations.welcomeSubtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(
    WidgetRef ref,
    AppLocalizations localizations,
    bool isExpanded,
  ) {
    return AnimatedOpacity(
      duration: fadeAnimationDuration,
      opacity: isExpanded ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: scaleAnimationDuration,
        height: isExpanded ? 50 : 0,
        child: WideButton(
          key: const ValueKey('expanded'),
          title: localizations.welcomeButtonTitle,
          onPressed: () => ref.read(isExpendedProvider.notifier).toggle(),
        ),
      ),
    );
  }
}
