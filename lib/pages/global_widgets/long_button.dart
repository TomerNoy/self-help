import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
