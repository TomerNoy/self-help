import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/stress_level/providers/stress_level_provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class StressLevel extends HookConsumerWidget {
  const StressLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(stressLevelProvider);
    final localizations = AppLocalizations.of(context)!;
    final width = Constants.minimumScreenWidth;

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.home) {
          updateAppBar(ref, localizations);
        }
      },
    );

    useEffect(() {
      updateAppBar(ref, localizations);
      return null;
    }, const []);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(pageFlowProvider.notifier).didPop();
        }
      },
      child: Scaffold(
        // appBar: FlowAppBar(
        //   title: localizations.measureTitle,
        //   subtitle: localizations.measureSubtitle,
        // ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: width,
                  child: SleekCircularSlider(
                    min: 1,
                    max: 10,
                    initialValue: 5,
                    appearance: CircularSliderAppearance(
                      startAngle: 180,
                      angleRange: 180,
                      customWidths: CustomSliderWidths(
                        progressBarWidth: 50,
                        trackWidth: 50,
                        shadowWidth: 0,
                        handlerSize: 20,
                      ),
                      customColors: CustomSliderColors(
                        progressBarColors: [
                          blue,
                          purple,
                        ],
                        trackColor: whiteGrey,
                        shadowColor: Colors.transparent,
                      ),
                      infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChange: (value) {
                      ref
                          .read(stressLevelProvider.notifier)
                          .updateState(value.round());
                    },
                    innerWidget: (_) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 100),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: SvgPicture.asset(
                              key: ValueKey(level),
                              AssetsConstants.faces[level - 1],
                              width: 80,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'לחוץ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '$level/10',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                'רגוע',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.continueButtonTitle,
        ),
        drawer: FlowDrawer(),
      ),
    );
  }

  void updateAppBar(WidgetRef ref, AppLocalizations localizations) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(animatedAppBarProvider.notifier).updateState(
            appBarType: AppBarType.expanded,
            appBarTitle: localizations.measureTitle,
            subtitle: localizations.measureSubtitle,
          ),
    );
  }
}
