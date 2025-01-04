// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:self_help/core/constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
// import 'package:self_help/pages/global_providers/user_provider.dart';
// import 'package:self_help/pages/global_widgets/animated_background.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/sos_landing/sos_landing.dart';
import 'package:self_help/services/services.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    // final user = ref.watch(userProvider);

    // final userName = user?.displayName ?? localizations.guest;

    // final paddingTop = MediaQuery.of(context).padding.top;
    // final collapsedPanelHeight = Constants.collapsedAppBarHeight + paddingTop;

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(collapsedPanelHeight),
      //   child: OpenContainer(
      //     transitionType: ContainerTransitionType.fadeThrough,
      //     closedElevation: 0,
      //     transitionDuration: const Duration(milliseconds: 300),
      //     closedShape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(50),
      //         bottomRight: Radius.circular(50),
      //       ),
      //     ),
      //     closedColor: Colors.transparent,
      //     closedBuilder: (context, action) {
      //       return Stack(
      //         children: [
      //           SizedBox.expand(
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(50),
      //                 bottomRight: Radius.circular(50),
      //               ),
      //               child: AnimatedBackground(),
      //             ),
      //           ),
      //           SizedBox.expand(
      //             child: SafeArea(
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                   horizontal: 32,
      //                   vertical: 16,
      //                 ),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       localizations.welcomeMessage(userName),
      //                       style: Theme.of(context).textTheme.headlineMedium,
      //                     ),
      //                     const SizedBox(height: 16),
      //                     Text(
      //                       'localizations.homeTitle',
      //                       style: Theme.of(context).textTheme.bodyLarge,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               // LargeButton(title: localizations.measureLevelButtonTitle),
      //               // LargeButton(title: localizations.measureLevelButtonTitle),
      //             ],
      //           )
      //         ],
      //       );
      //     },
      //     openBuilder: (context, action) {
      //       return SosLanding();
      //     },
      //     onClosed: (data) {
      //       loggerService.debug('onClosed data: $data');
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 230,
          left: 16,
          right: 16,
        ),
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
                            ref
                                .read(collapsingAppBarProvider.notifier)
                                .updateState(AppBarType.sos);
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
              onPressed: () async => await userService.signOut(),
              icon: Icon(Icons.build),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              icon: Icon(Icons.build),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SosLanding(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0); // Slide from top to bottom
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0); // Fade effect

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}
