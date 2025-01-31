// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:self_help/core/constants/assets_constants.dart';
// import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
// import 'package:self_help/pages/global_widgets/animated_background.dart';
// import 'package:self_help/pages/global_widgets/collapsing_appbar/collapsing_appbar_config.dart';
// import 'package:self_help/pages/global_widgets/wide_button.dart';
// import 'package:self_help/pages/loading.dart';
// import 'package:self_help/services/services.dart';

// class CollapsingAppbar extends ConsumerWidget {
//   const CollapsingAppbar({super.key});

//   static const animationDuration = Duration(milliseconds: 300);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appBarType = ref.watch(collapsingAppBarProvider);
//     final logo = Image.asset(AssetsConstants.selfHelpNoBk);
//     final config = AppBarContent(context: context, state: appBarType, ref: ref);

//     if (appBarType == AppBarType.loading) {
//       return Loading();
//     }

//     loggerService.debug('CollapsingAppbar: appBarType: $appBarType');

//     final isExpanded = [
//       AppBarType.welcome,
//       AppBarType.sos,
//       AppBarType.gainControl,
//       AppBarType.loading,
//     ].contains(appBarType);

//     // logo
//     final logoWidget = SafeArea(
//       bottom: false,
//       child: AnimatedContainer(
//         duration: animationDuration,
//         height: config.logoHeight,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AnimatedContainer(
//                 duration: animationDuration,
//                 width: 50,
//                 height: [
//                   AppBarType.sos,
//                   AppBarType.gainControl,
//                   AppBarType.profile,
//                   AppBarType.settings,
//                 ].contains(appBarType)
//                     ? 50
//                     : 0,
//                 child: FittedBox(
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white24,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: IconButton(
//                         onPressed: config.backPressed,
//                         icon: const Icon(
//                           Icons.arrow_back_ios_new,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               FittedBox(child: logo),
//               SizedBox(width: 50),
//             ],
//           ),
//         ),
//       ),
//     );

//     // title
//     final titleWidget = AnimatedSwitcher(
//       duration: animationDuration,
//       transitionBuilder: (child, animation) {
//         return ScaleTransition(
//           scale: animation,
//           child: child,
//         );
//       },
//       child: Text(
//         key: ValueKey('$appBarType'),
//         config.title,
//         style: Theme.of(context).textTheme.headlineMedium,
//         textAlign: TextAlign.center,
//       ),
//     );

//     // subtitle
//     final subtitleWidget = AnimatedContainer(
//       duration: animationDuration,
//       height: config.subtitleHeight,
//       child: AnimatedOpacity(
//         duration: animationDuration,
//         opacity: config.opacity,
//         child: Text(
//           config.subtitle,
//           style: Theme.of(context).textTheme.bodyLarge,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );

//     // button
//     final buttonWidget = AnimatedContainer(
//       duration: animationDuration,
//       height: config.buttonHeight,
//       child: AnimatedOpacity(
//         duration: animationDuration,
//         opacity: config.opacity,
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: WideButton(
//             onPressed: config.startPressed,
//             title: config.buttonTitle,
//             type: ButtonType.transparent,
//             width: double.infinity,
//           ),
//         ),
//       ),
//     );

//     return AnimatedOpacity(
//       duration: animationDuration,
//       opacity: appBarType == AppBarType.hidden ? 0.0 : 1.0,
//       child: AnimatedContainer(
//         duration: animationDuration,
//         width: double.infinity,
//         height: config.animationHeight,
//         child: TweenAnimationBuilder<BorderRadius>(
//           duration: animationDuration,
//           curve: Curves.easeInOut,
//           tween: Tween(
//             begin: BorderRadius.vertical(
//               bottom: Radius.circular(isExpanded ? 50 : 0),
//             ),
//             end: BorderRadius.vertical(
//               bottom: Radius.circular(isExpanded ? 0 : 50),
//             ),
//           ),
//           builder: (context, radius, child) {
//             return ClipRRect(
//               borderRadius: radius,
//               child: Stack(
//                 children: [
//                   SizedBox.expand(
//                     child: const AnimatedBackground(),
//                   ),
//                   Center(
//                     child: Material(
//                       color: Colors.transparent,
//                       child: LayoutBuilder(
//                         builder: (context, constraints) {
//                           return SingleChildScrollView(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 minHeight: constraints.maxHeight,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Directionality(
//                                     textDirection: TextDirection.rtl,
//                                     child: logoWidget,
//                                   ),
//                                   Column(
//                                     children: [
//                                       titleWidget,
//                                       const SizedBox(height: 16),
//                                       subtitleWidget,
//                                     ],
//                                   ),
//                                   buttonWidget,
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
