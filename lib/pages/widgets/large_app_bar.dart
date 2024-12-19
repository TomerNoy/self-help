import 'package:flutter/material.dart';
import 'package:self_help/core/strings.dart';
import 'package:self_help/core/widgets/animated_background.dart';

class LargeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LargeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      // child: AnimatedBackground(
      //     height: preferredSize.height,
      //     child: Directionality(
      //       textDirection: TextDirection.rtl,
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Spacer(flex: 4),
      //             Text(
      //               'הי דניאל!',
      //               style: Theme.of(context).textTheme.headlineMedium,
      //             ),
      //             Spacer(),
      //             Text(
      //               Strings.homeTitle,
      //               style: Theme.of(context).textTheme.titleMedium,
      //             ),
      //             Spacer(flex: 6),
      //           ],
      //         ),
      //       ),
      //     )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300);
}
