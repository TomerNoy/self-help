// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
// import 'package:self_help/services/services.dart';
//
// enum UpdateValueType { name, email }
//
// class ProfileDialogButton extends ConsumerWidget {
//   const ProfileDialogButton({
//     super.key,
//     required this.value,
//     required this.updateValueType,
//   });
//
//   final String value;
//   final UpdateValueType updateValueType;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return IconButton(
//       onPressed: () {
//         String newValue = value;
//
//         showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: Text('Edit ${updateValueType.name.toUpperCase()}'),
//             content: TextField(
//               controller: TextEditingController(text: newValue),
//               decoration: InputDecoration(labelText: 'Name'),
//               onChanged: (value) => newValue = value,
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Cancel'),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//
//                   ref
//                       .read(collapsingAppBarProvider.notifier)
//                       .updateState(AppBarType.loading);
//
//                   final result = await switch (updateValueType) {
//                     UpdateValueType.name =>
//                       userService.updateUserName(name: newValue),
//                     UpdateValueType.email => userService.updateUserEmail(
//                         email: newValue,
//                         password: 'password',
//                       ),
//                   };
//
//                   ref
//                       .read(collapsingAppBarProvider.notifier)
//                       .updateState(AppBarType.hidden);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       },
//       icon: Icon(
//         Icons.edit,
//         size: 32,
//       ),
//     );
//   }
// }
