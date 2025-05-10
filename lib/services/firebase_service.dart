import 'package:firebase_core/firebase_core.dart';
import 'package:self_help/firebase_options.dart';
import 'package:self_help/services/logger_service.dart';

class FirebaseService {
  init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      LoggerService.error('firebase init error', e);
    }
  }
}
