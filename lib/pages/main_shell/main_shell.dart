import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/core/constants/flow_route_constant.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/services/services.dart';

// todo add fade transition to appbar

class MainShell extends HookConsumerWidget {
  const MainShell({
    super.key,
    required this.child,
    required this.page,
  });

  final Widget child;
  final RoutePaths? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(animatedAppBarProvider);
    loggerService.debug('§ appState $appState');

    final appBarType = appState.appBarType;
    final appBarTitle = appState.appBarTitle;
    final subtitle = appState.subtitle;
    final fullScreenTitle = appState.fullScreenTitle;
    final logo = appState.logo;

    final hasBackButton = appState.hasBackButton;
    final startCallback = appState.startCallback;

    final isFullScreen = appBarType == AppBarType.fullScreen;

    const radius = BorderRadius.vertical(
      bottom: Radius.circular(30),
    );
    final borderRadius = isFullScreen ? null : radius;

    final bottomHeight = switch (appBarType) {
      AppBarType.collapsed => 0.0,
      AppBarType.expanded => 60.0,
      AppBarType.fullScreen => MediaQuery.of(context).size.height -
          AppBar().preferredSize.height -
          MediaQuery.of(context).padding.top,
    };
    // loggerService.debug('measureKey height ${size.value?.height}');

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: MediaQuery.of(context).size,
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: Constants.animationDuration,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                    ),
                    child: const AnimatedBackground(),
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(appBarTitle ?? ''),
                  titleTextStyle: Theme.of(context).textTheme.headlineMedium,
                  centerTitle: true,
                  leading: hasBackButton
                      ? IconButton.filled(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white30,
                            ),
                          ),
                          onPressed: () => ref.read(routerStateProvider).pop(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                        )
                      : null,
                  bottom: PreferredSize(
                    preferredSize: MediaQuery.of(context).size,
                    child: AnimatedContainer(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      duration: Constants.animationDuration,
                      height: bottomHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (logo != null)
                            Flexible(
                              child: Image.asset(
                                AssetsConstants.selfHelpNoBk,
                                height: 140.0,
                              ),
                            ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (fullScreenTitle != null)
                                  Flexible(
                                    child: Text(
                                      '$fullScreenTitle\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                if (subtitle != null)
                                  Flexible(
                                    child: Text(
                                      subtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (startCallback != null)
                            Flexible(
                              child: Center(
                                child: WideButton(
                                  title: 'המשך',
                                  onPressed: startCallback,
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
              ],
            ),
          ),
        ),
        // PreferredSize(
        //   preferredSize: MediaQuery.of(context).size,
        //   child: AnimatedContainer(
        //     duration: Constants.animationDuration,
        //     height: 200,
        //     child: Stack(
        //       key: ValueKey('${page?.name}'),
        //       children: [
        //         Positioned.fill(
        //           child: const AnimatedBackground(),
        //         ),
        //         // animated screen content
        //         SafeArea(
        //           child: AnimatedSwitcher(
        //             duration: Constants.animationDuration,
        //             transitionBuilder: (child, animation) {
        //               return FadeTransition(
        //                 // key: ValueKey('${page?.name}'),
        //                 opacity: animation,
        //                 child: child,
        //               );
        //             },
        //             // sizeed box used only for the key
        //             child: SizedBox(
        //               // key: ValueKey('${page?.name}'),
        //               child: switch (appBarType) {
        //                 AppBarType.hidden => const SizedBox.shrink(),
        //                 _ => Center(
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(16),
        //                       child: Column(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceAround,
        //                         children: [
        //                           if (hasBackButton) _buildBackButton(ref),
        //                           if (hasLogo) _buildLogo(),
        //                           Column(
        //                             children: [
        //                               Text(
        //                                 title,
        //                                 style: Theme.of(context)
        //                                     .textTheme
        //                                     .headlineMedium,
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                               if (subtitle.isNotEmpty)
        //                                 Text(
        //                                   '\n$subtitle',
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .bodyMedium,
        //                                   textAlign: TextAlign.center,
        //                                 ),
        //                             ],
        //                           ),
        //                           if (hasStartButton)
        //                             _buildStartButton(localizations, ref),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //               },
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: child,
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

  // void _backPressed(WidgetRef ref) {
  //   ref.read(routerStateProvider).pop();
  // }

  // Widget _buildBackButton(WidgetRef ref) {
  //   return Expanded(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         IconButton.filled(
  //           style: ButtonStyle(
  //             backgroundColor: WidgetStateProperty.all(
  //               Colors.white30,
  //             ),
  //           ),
  //           onPressed: () => _backPressed(ref),
  //           icon: Icon(
  //             Icons.arrow_back_ios_new,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
    String subtitle,
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
                  subtitle,
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
