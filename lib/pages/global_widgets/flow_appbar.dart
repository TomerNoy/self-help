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

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SafeArea(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: 16),
          Flexible(
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(170);
}
