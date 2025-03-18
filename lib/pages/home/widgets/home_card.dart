import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/pages/global_widgets/buttons.dart';

class HomeCard extends ConsumerWidget {
  const HomeCard({
    super.key,
    required this.description,
    required this.buttonTitle,
    required this.imagePath,
    required this.onPressed,
  });

  final String description;
  final String buttonTitle;
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                Size(500, 140),
              ),
              child: Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            GradientElevatedButton(
                              maxWidth: 200,
                              minWidth: 100,
                              onPressed: onPressed,
                              title: buttonTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 176),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 16,
              child: SvgPicture.asset(imagePath, width: 140),
            ),
          ],
        ),
      ),
    );
  }
}
