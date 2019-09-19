import 'dart:ui';

import 'package:kib/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static SharedPreferences _prefs;

  DataStore._privateConstructor();

  static final DataStore _instance = DataStore._privateConstructor();

  static initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory DataStore() {
    initPrefs();
    return _instance;
  }

  User getUser() {
    var userStr = _prefs.getString("user");
    var u = userStr != null ? userFromJson(userStr) : User();
    return u;
  }

  setUser(User user) {
    print("save user");
    _prefs.setString("user", userToJson(user));
  }

  setUserToken(String accessToken) {
    _prefs.setString('access_token', accessToken);
  }

  setLocale(Locale locale) {
    var languageCode = locale.languageCode;
    var countryCode = locale.countryCode;
    _prefs.setString('country_code', countryCode);
    _prefs.setString('language_code', languageCode);
  }

  Locale getLocale()  {
    // var _prefs = await SharedPreferences.getInstance();
    var languageCode = _prefs.getString('language_code');
    var countryCode = _prefs.getString('country_code');
    if (languageCode == null) {
      languageCode = 'US';
    }
    if (countryCode == null) {
      countryCode = '';
    }
    return Locale(languageCode, countryCode);
  }

  User get me => getUser();

  String get userToken => _prefs.getString('access_token');

  bool get isUserLoggedIn => _prefs.getString('access_token') != null;

  get logout => _prefs.clear();
}
