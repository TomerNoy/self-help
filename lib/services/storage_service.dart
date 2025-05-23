import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _pref;

  Future<void> init() async => _pref = await SharedPreferences.getInstance();

  int readBreathInDuration() => _pref.getInt('BreathInDuration') ?? 3;
  int readPeakHoldDuration() => _pref.getInt('PeakHoldDuration') ?? 2;
  int readBreathOutDuration() => _pref.getInt('BreathOutDuration') ?? 6;
  int readBaseHoldDuration() => _pref.getInt('BaseHoldDuration') ?? 0;
  int readRepeats() => _pref.getInt('Repeats') ?? 4;

  String readPreferredLanguage() {
    return _pref.getString('PreferredLanguage') ?? 'he';
  }

  void writeBreathInDuration(int i) => _pref.setInt('BreathInDuration', i);
  void writePeakHoldDuration(int i) => _pref.setInt('PeakHoldDuration', i);
  void writeBreathOutDuration(int i) => _pref.setInt('BreathOutDuration', i);
  void writeBaseHoldDuration(int i) => _pref.setInt('BaseHoldDuration', i);
  void writeRepeats(int i) => _pref.setInt('Repeats', i);

  void writePreferredLanguage(String language) {
    _pref.setString('PreferredLanguage', language);
  }
}
