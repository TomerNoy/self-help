// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:self_help/routes/app_routes.dart';
// import 'package:self_help/services/services.dart';

// final pageRouteProvider = Provider((ref) => FlowController());

// class FlowController extends StateNotifier<int> {
//   FlowController() : super(0);

//   final List<String> flow1 = [
//     AppRoutes.measure,
//     AppRoutes.breathing,
//     AppRoutes.measure,
//     AppRoutes.butterfly,
//     AppRoutes.measure,
//   ];
//   final List<String> flow2 = [
//     AppRoutes.measure,
//     AppRoutes.butterfly,
//     AppRoutes.measure,
//     AppRoutes.breathing,
//     AppRoutes.measure,
//   ];
//   late List<String> currentFlow;

//   void startFlow(int flowNumber) {
//     currentFlow = flowNumber == 1 ? flow1 : flow2;
//     state = 0;
//   }

//   bool get isLast => state == currentFlow.length - 1;

//   String get currentRoute => currentFlow[state];

//   int get currentState => state;

//   void next(BuildContext context) {
//     loggerService
//         .debug('state: $state, currentFlow.length: ${currentFlow.length}');

//     if (state < currentFlow.length - 1) {
//       state++;
//       Navigator.pushNamed(context, currentFlow[state]);
//       loggerService.debug('push to state: $state');
//     }
//   }

//   void backNoPop() => state--;

//   void end(BuildContext context) {
//     loggerService.debug('Ending flow, resetting state to 0');
//     state = 0;
//     Navigator.popUntil(
//       context,
//       (route) {
//         final routeName = route.settings.name;
//         loggerService.debug('Checking route: $routeName');
//         return routeName == AppRoutes.home;
//       },
//     );
//   }
// }
