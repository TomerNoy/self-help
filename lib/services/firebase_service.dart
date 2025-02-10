import 'package:firebase_core/firebase_core.dart';
import 'package:self_help/firebase_options.dart';

class FirebaseService {
  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
