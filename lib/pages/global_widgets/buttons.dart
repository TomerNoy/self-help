import 'package:flutter/material.dart';

class GradientFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? maxWidth;
  final double? minWidth;

  const GradientFilledButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.maxWidth,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimary,
    );
    final borderRadius = BorderRadius.circular(25);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: 40,
      ),
      child: Ink(
        height: 30,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.tertiary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class GradientElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? maxWidth;
  final double? minWidth;

  const GradientElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.maxWidth,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimary,
    );
    final borderRadius = BorderRadius.circular(25);

    return Material(
      elevation: 2,
      borderRadius: borderRadius,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: 40,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.tertiary,
                colorScheme.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: borderRadius,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: Center(
              child: Text(
                title,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? maxWidth;
  final double? minWidth;
  const GradientOutlinedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.maxWidth,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gtextStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimaryContainer,
    );
    final borderRadius = BorderRadius.circular(25);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: 40,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: colorScheme.onPrimaryContainer,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          child: Center(
            child: Text(
              title,
              style: gtextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
