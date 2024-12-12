// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get welcomeTitle => 'ברוכים הבאים לSelf Help!';

  @override
  String get login => 'התחברות';

  @override
  String get welcomeSubtitle => 'פרוטוקול עזרה עצמית\nלהתמודדות עם לחץ וחרדה';

  @override
  String get welcomeButtonTitle => 'כניסה';

  @override
  String get email => 'דואר אלקטרוני';

  @override
  String get password => 'סיסמה';

  @override
  String get repeatPassword => 'חזור על הסיסמה';

  @override
  String get forgotPassword => 'שכחתי סיסמה';

  @override
  String get or => 'או';

  @override
  String get dontHaveAccount => 'אין לך משתמש?';

  @override
  String get registerNow => 'הירשם עכשיו';

  @override
  String get registeration => 'הרשמה';

  @override
  String get register => 'הרשם';

  @override
  String get backToLoing => 'חזור להתחברות';

  @override
  String get name => 'שם משתמש';

  @override
  String welcomeMessage(String name) {
    return 'היי $name!';
  }

  @override
  String get homeTitle => 'המקום הנכון לטיפול באופן עצמאי\nבהתמודדות עם לחץ וחרדה';

  @override
  String get guest => 'אורח';

  @override
  String get startSosButtonTitle => 'להתחיל תרגיל SOS';
}
