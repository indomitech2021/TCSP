import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static String _keyID = "ID";
  static String _keyName = "NAME";
  static String _keyPhone = "PHONE";
  static String _keyEmail = "EMAIL";
  static String _keyPwd = "PASSWORD";
  static String _keyPic = "PROFILE";
  static String _keyResume = "RESUME";

  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Set ID
  static Future setID(String value) async =>
      await _preferences.setString(_keyID, value);
  static String? getID() => _preferences.getString(_keyID);

  /// User type
  static Future setName(String value) async =>
      await _preferences.setString(_keyName, value);
  static String? getName() => _preferences.getString(_keyName);

  /// Phone
  static Future setPhone(String value) async =>
      await _preferences.setString(_keyPhone, value);
  static String? getPhone() => _preferences.getString(_keyPhone);

  /// full name
  static Future setEmail(String value) async =>
      await _preferences.setString(_keyEmail, value);
  static String? getEmail() => _preferences.getString(_keyEmail);

  /// email
  static Future setPwd(String value) async =>
      await _preferences.setString(_keyPwd, value);
  static String? getPwd() => _preferences.getString(_keyPwd);

  /// pic
  static Future setPic(String value) async =>
      await _preferences.setString(_keyPic, value);
  static String? getPic() => _preferences.getString(_keyPic);

  static Future setResume(String value) async =>
      await _preferences.setString(_keyResume, value);
  static String? getResume() => _preferences.getString(_keyResume);


  static Future deleteByKey(String value) async {
    await _preferences.remove(value);
  }

  static Future deleteAllData() async {
    await _preferences.clear();
  }

}