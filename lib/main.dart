import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/app.dart';
import 'package:self_help/services/services.dart';
import 'package:self_help/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    loggerService.debug('app started');
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: generateTheme(),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: App(),
        ),
      ),
    );
  }
}
