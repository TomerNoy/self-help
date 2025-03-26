import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';

class CollapsingAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CollapsingAppbar({
    super.key,
    required this.size,
  });

  final Size size;

// TODO: add fade transition to appbar?

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
    final subtitleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          height: 1.5,
        );
    final appBarHeight = AppBar().preferredSize.height;
    final padding = MediaQuery.of(context).padding.top;

    double bottomHeight = 0.0;

    if (appBarType == AppBarType.expanded) {
      final textPainter = TextPainter(
        text: TextSpan(text: subtitle, style: subtitleStyle),
        maxLines: null,
        textDirection: TextDirection.rtl,
      )..layout(maxWidth: MediaQuery.of(context).size.width - padding);
      bottomHeight = textPainter.height + 16;
    } else if (appBarType == AppBarType.fullScreen) {
      bottomHeight =
          MediaQuery.of(context).size.height - appBarHeight - padding;
    }

    return IntrinsicHeight(
      child: AnimatedContainer(
        duration: Constants.animationDuration,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            appBarTitle ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          centerTitle: true,
          // actions: [
          //   _buildMenuButton(ref),
          // ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.inversePrimary,
                  Theme.of(context).colorScheme.surfaceDim,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          actions: [
            if (hasBackButton)
              IconButton.filled(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white30,
                  ),
                ),
                onPressed: () => ref.read(routerStateProvider).pop(),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
          ],
          bottom: PreferredSize(
            preferredSize: MediaQuery.of(context).size,
            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxWidth: 800,
              ),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
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
                                  .headlineMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (subtitle != null)
                          Flexible(
                            child: Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: subtitleStyle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (startCallback != null)
                    Flexible(
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: GradientFilledButton(
                            onPressed: startCallback,
                            title: 'המשך',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
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
