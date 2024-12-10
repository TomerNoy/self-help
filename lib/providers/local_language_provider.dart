import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/services/services.dart';

part 'local_language_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    return Locale(storageService.readPreferedLanguage());
  }

  void updateLocal(int i) {
    switch (i) {
      case 0:
        state = const Locale('he');
        break;
      case 1:
        state = const Locale('en');
        break;
    }
    storageService.writePreferedLanguage(state.languageCode);
  }
}
