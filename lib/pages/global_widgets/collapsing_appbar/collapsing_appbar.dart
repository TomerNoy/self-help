import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';

class CollapsingAppbar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const CollapsingAppbar({
    super.key,
    required this.size,
  });

  final Size size;

// TODO add fade transition to appbar?

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(animatedAppBarProvider);

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
    final subtitleStyle = Theme.of(context).textTheme.bodyMedium;
    final appBarHeight = AppBar().preferredSize.height;
    final padding = MediaQuery.of(context).padding.top;

    double bottomHeight = 0.0;

    if (appBarType == AppBarType.expanded) {
      final textPainter = TextPainter(
        text: TextSpan(text: subtitle, style: subtitleStyle),
        maxLines: null,
        textDirection: TextDirection.rtl,
      )..layout(maxWidth: MediaQuery.of(context).size.width - padding);
      bottomHeight = textPainter.height + 32;
    } else if (appBarType == AppBarType.fullScreen) {
      bottomHeight = MediaQuery.of(context).size.height - appBarHeight;
    }

    return IntrinsicHeight(
      child: AnimatedContainer(
        duration: Constants.animationDuration,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            Positioned.fill(child: const AnimatedBackground()),
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
                                  style: subtitleStyle,
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

  @override
  Size get preferredSize => size;
}
