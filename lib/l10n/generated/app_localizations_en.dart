// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTitle => 'Welcome to Self Help!';

  @override
  String get login => 'Login';

  @override
  String get welcomeSubtitle => 'Self-help protocol\nfor dealing with stress and anxiety';

  @override
  String get welcomeButtonTitle => 'Enter';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get or => 'or';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register now';

  @override
  String get registeration => 'Registration';

  @override
  String get register => 'Register';

  @override
  String get backToLoing => 'Back to login';

  @override
  String get name => 'User Name';

  @override
  String welcomeMessage(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homeTitle => 'The right place for self-treatment\nin dealing with stress and anxiety';

  @override
  String get guest => 'Guest';

  @override
  String get startSosButtonTitle => 'Start SOS exercise';
}
