import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  final SharedPreferences _prefs;
  static const String FIGHT_RESULT_KEY = 'fight_result';
  static const String FIGHT_RESULT_WIN_KEY = 'fight_result_win';
  static const String FIGHT_RESULT_LOST_KEY = 'fight_result_lost';
  static const String FIGHT_RESULT_DRAW_KEY = 'fight_result_draw';

  SharedPrefRepository(this._prefs);

  String? getFightResult() {
    return _prefs.getString(FIGHT_RESULT_KEY);
  }

  Future<void> setFightResult(String value) async {
    await _prefs.setString(FIGHT_RESULT_KEY, value);
  }

  Future<void> increaseDraw() async {
    getFightDraw();

    await _prefs.setInt(FIGHT_RESULT_DRAW_KEY, getFightDraw() + 1);
  }

  int getFightDraw() {
    return _prefs.getInt(FIGHT_RESULT_DRAW_KEY) ?? 0;
  }

  Future<void> increaseLost() async {
    await _prefs.setInt(FIGHT_RESULT_LOST_KEY, getFightLost() + 1);
  }

  int getFightLost() {
    return _prefs.getInt(FIGHT_RESULT_LOST_KEY) ?? 0;
  }

  Future<void> increaseWin() async {
    await _prefs.setInt(FIGHT_RESULT_WIN_KEY, getFightWin() + 1);
  }

  int getFightWin() {
    return _prefs.getInt(FIGHT_RESULT_WIN_KEY) ?? 0;
  }
}
