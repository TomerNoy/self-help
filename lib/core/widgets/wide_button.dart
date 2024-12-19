import 'package:flutter/material.dart';

enum ButtonType { transparent, gradient, black }

class WideButton extends StatelessWidget {
  const WideButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.type,
    this.width,
  });

  final String title;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: onPressed == null
          ? ElevatedButton(
              onPressed: null,
              child: Text(title),
            )
          : switch (type) {
              ButtonType.gradient => ElevatedButton(
                  onPressed: onPressed,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF79C3DD),
                          Color(0xFF6E79ED),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              _ => OutlinedButton(
                  onPressed: onPressed,
                  style: switch (type) {
                    ButtonType.black =>
                      Theme.of(context).outlinedButtonTheme.style!.copyWith(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF1A1A1A)),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                    _ => null,
                  },
                  child: Text(title),
                )
            },
    );
  }
}
