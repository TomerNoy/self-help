import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_help/core/theme.dart';
// import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_widgets/wide_button.dart';

class HomeCard extends ConsumerWidget {
  const HomeCard({
    super.key,
    required this.backgroundColor,
    required this.description,
    required this.buttonTitle,
    required this.imagePath,
    required this.onPressed,
  });

  final Color backgroundColor;
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
                Size(800, 180),
              ),
              child: SizedBox(
                height: 160,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  shadowColor: Color(0x1A7E57C2),
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          purple3.withAlpha(100),
                          blue3.withAlpha(100),
                          // whiteGrey,
                          // blue3,
                          // white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Color(0x337E57C2),
                        width: 0.5,
                      ),
                    ),
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
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                WideButton(
                                  width: 160,
                                  title: buttonTitle,
                                  onPressed: onPressed,
                                  type: ButtonType.gradient,
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
              ),
            ),
            Positioned(
              top: 0,
              left: 16,
              child: SvgPicture.asset(imagePath, width: 160),
            ),
          ],
        ),
      ),
    );
  }
}
