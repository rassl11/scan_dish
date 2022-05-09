import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keySubscribeFirst = 'Name';

  Future update() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.reload();
  }

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setName(String username) async {
    await _preferences!.setString(_keySubscribeFirst, username);
    await UserSimplePreferences().update();
  }

  static String? getName() => _preferences!.getString(_keySubscribeFirst);
}
