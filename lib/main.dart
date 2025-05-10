import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/app.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.init();
  runApp(
    ProviderScope(
      observers: [MyProviderObserver()],
      child: const App(),
    ),
  );
}

class MyProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    LoggerService.debug('''
provider: ${provider.name ?? provider.runtimeType}
newValue: $newValue
''');
  }
}
