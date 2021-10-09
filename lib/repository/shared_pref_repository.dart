import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  final SharedPreferences _prefs;
  static const String FIGHT_RESULT_KEY = 'fight_result';

  SharedPrefRepository(this._prefs);

  String? getFightResult() {
    _prefs.getString(FIGHT_RESULT_KEY);
  }

  Future<void> serFightResult(String value) async {
    await _prefs.setString(FIGHT_RESULT_KEY, value);
  }
}
