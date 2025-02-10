import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/app.dart';
import 'package:self_help/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.init();
  runApp(
    ProviderScope(
      child: const App(),
    ),
  );
}

/// todo
/// - do i still need router listener?
