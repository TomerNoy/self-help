import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/providers/local_language_provider.dart';

class WelcomeLanguageButton extends ConsumerWidget {
  const WelcomeLanguageButton({super.key});

  static const padding = EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ToggleButtons(
        isSelected: [
          locale.languageCode == 'he',
          locale.languageCode == 'en',
        ],
        borderRadius: BorderRadius.circular(10),
        selectedColor: Theme.of(context).colorScheme.onPrimary,
        children: [
          Padding(padding: padding, child: Text('עברית')),
          Padding(padding: padding, child: Text('English')),
        ],
        onPressed: (i) {
          ref.read(localeNotifierProvider.notifier).updateLocal(i);
        },
      ),
    );
  }
}
