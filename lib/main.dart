import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/app.dart';
import 'package:self_help/firebase_options.dart';
import 'package:self_help/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ServiceProvider.init();
  runApp(
    ProviderScope(
      child: const App(),
    ),
  );
}



/// todo
/// - do i still need router listener?
