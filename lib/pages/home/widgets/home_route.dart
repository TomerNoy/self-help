import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
