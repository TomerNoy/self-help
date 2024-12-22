import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PageAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final flowController = ref.read(pageRouteProvider);
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // flowController.end(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
