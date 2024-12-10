import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
              backgroundColor: WidgetStateProperty.all(backgroundColor),
              foregroundColor: WidgetStateProperty.all(textColor),
            ),
        child: Text(title),
      ),
    );
  }
}
