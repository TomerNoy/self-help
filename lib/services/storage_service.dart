import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _pref;

  Future<void> init() async => _pref = await SharedPreferences.getInstance();

  int getBreathInDuration() => _pref.getInt('BreathInDuration') ?? 4;
  int getPeakHoldDuration() => _pref.getInt('PeakHoldDuration') ?? 4;
  int getBreathOutDuration() => _pref.getInt('BreathOutDuration') ?? 4;
  int getBaseHoldDuration() => _pref.getInt('BaseHoldDuration') ?? 4;
  int getRepeats() => _pref.getInt('Repeats') ?? 2;

  void writeBreathInDuration(int i) => _pref.setInt('BreathInDuration', i);
  void writePeakHoldDuration(int i) => _pref.setInt('PeakHoldDuration', i);
  void writeBreathOutDuration(int i) => _pref.setInt('BreathOutDuration', i);
  void writeBaseHoldDuration(int i) => _pref.setInt('BaseHoldDuration', i);
  void writeRepeats(int i) => _pref.setInt('Repeats', i);
}
