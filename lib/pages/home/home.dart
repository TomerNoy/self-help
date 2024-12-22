import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:self_help/core/providers/collapsing_appbar_provider.dart';
import 'package:self_help/core/providers/user_provider.dart';
import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/core/router.dart';
import 'package:self_help/services/services.dart';
import 'package:self_help/theme.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final flowController = ref.read(pageRouteProvider);

    final collapsedPanelHeight = 150.0;

    final localizations = AppLocalizations.of(context)!;
    final userProvider = ref.watch(userStateProvider);

    final userName = userProvider.value?.displayName ?? localizations.guest;

    loggerService.debug('userProvider value: ${userProvider.value}');
    final test = MediaQuery.of(context).padding.top;
    loggerService.debug('test: $test');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(collapsedPanelHeight),
        child: Stack(
          children: [
            SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: AnimatedBackground(),
              ),
            ),
            SizedBox.expand(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        localizations.welcomeMessage(userName),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        localizations.homeTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // LargeButton(title: localizations.measureLevelButtonTitle),
                // LargeButton(title: localizations.measureLevelButtonTitle),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: greyBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'some text',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: 16),
                        WideButton(
                          title: localizations.startSosButtonTitle,
                          onPressed: () {
                            context.pushNamed(RouteNames.sosLanding);
                          },
                          type: ButtonType.gradient,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/sos_girl.svg',
                    height: 142,
                    width: 106,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                ref.read(collapsingAppBarProvider.notifier).state =
                    AppBarState.collapsed;
                await userService.signOut();
              },
              icon: Icon(Icons.build),
            ),
          ],
        ),
      ),
    );
  }
}
