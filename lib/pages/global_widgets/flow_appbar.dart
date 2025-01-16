import 'package:flutter/material.dart';
import 'package:self_help/services/services.dart';

class FlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlowAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    loggerService.debug('${MediaQuery.of(context).padding.top}');

    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      leading: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: SizedBox(
          height: 140,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 140);
}
