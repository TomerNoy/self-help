import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar_config.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/pages/loading.dart';
import 'package:self_help/services/services.dart';

class CollapsingAppbar extends ConsumerWidget {
  const CollapsingAppbar({super.key});

  static const animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarType = ref.watch(collapsingAppBarProvider);
    final logo = SvgPicture.asset('assets/icons/logo.svg');
    final config = AppBarContent(context: context, state: appBarType, ref: ref);

    if (appBarType == AppBarType.hidden) {
      return const SizedBox.shrink();
    }
    if (appBarType == AppBarType.loading) {
      return Loading();
    }

    loggerService.debug('CollapsingAppbar: appBarType: $appBarType');
    final isExpanded = [
      AppBarType.welcome,
      AppBarType.sos,
    ].contains(appBarType);

    // logo
    final logoWidget = SafeArea(
      bottom: false,
      child: AnimatedContainer(
        duration: animationDuration,
        height: config.logoHeight,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: animationDuration,
                width: 50,
                height: appBarType == AppBarType.sos ? 50 : 0,
                child: FittedBox(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          ref
                              .read(collapsingAppBarProvider.notifier)
                              .updateState(AppBarType.home);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FittedBox(child: logo),
              SizedBox(width: 50),
            ],
          ),
        ),
      ),
    );

    // title
    final titleWidget = AnimatedSwitcher(
      duration: animationDuration,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Text(
        key: ValueKey('$appBarType'),
        config.title,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );

    // subtitle
    final subtitleWidget = AnimatedContainer(
      duration: animationDuration,
      height: config.subtitleHeight,
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: config.opacity,
        child: Text(
          config.subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );

    // button
    final buttonWidget = AnimatedContainer(
      duration: animationDuration,
      height: config.buttonHeight,
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: config.opacity,
        child: Align(
          alignment: Alignment.topCenter,
          child: WideButton(
            onPressed: config.cb,
            title: config.buttonTitle,
            type: ButtonType.transparent,
            width: double.infinity,
          ),
        ),
      ),
    );

    return AnimatedContainer(
      duration: animationDuration,
      width: double.infinity,
      height: config.animationHeight,
      child: TweenAnimationBuilder<BorderRadius>(
        duration: animationDuration,
        curve: Curves.easeInOut,
        tween: Tween(
          begin: BorderRadius.vertical(
            bottom: Radius.circular(isExpanded ? 50 : 0),
          ),
          end: BorderRadius.vertical(
            bottom: Radius.circular(isExpanded ? 0 : 50),
          ),
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: logoWidget,
                          ),
                          Column(
                            children: [
                              titleWidget,
                              const SizedBox(height: 16),
                              subtitleWidget,
                            ],
                          ),
                          buttonWidget,
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
