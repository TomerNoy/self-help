// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:self_help/pages/widgets/long_button.dart';
// import 'package:self_help/providers/page_route_provider.dart';

// class StepNavigator extends ConsumerWidget {
//   const StepNavigator({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final flowController = ref.watch(pageRouteProvider);
//     final isLastStep = flowController.isLast;
//     final currentState = flowController.currentState;

//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [],
//           ),

//           // AnimatedContainer(
//           //   duration: const Duration(milliseconds: 300),
//           //   decoration: BoxDecoration(
//           //     border: Border.all(color: Colors.black),
//           //     borderRadius: BorderRadius.circular(10),
//           //   ),
//           //   height: 30,
//           //   width: double.infinity,
//           // ),
//           isLastStep
//               ? LongButton(
//                   label: 'סיום',
//                   onPressed: () => flowController.end(context),
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                         '$currentState / total: ${flowController.currentFlow.length - 1}'),
//                     LongButton(
//                       label: 'המשך לשלב הבא',
//                       onPressed: () => flowController.next(context),
//                     ),
//                     LongButton(
//                       label: 'דלג על התרגול',
//                       onPressed: () => flowController.next(context),
//                     ),
//                   ],
//                 ),
//         ],
//       ),
//     );
//   }
// }
