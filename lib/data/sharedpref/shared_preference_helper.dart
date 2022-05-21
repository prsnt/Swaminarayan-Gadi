import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  late SharedPreferences _sharedPreference;

  Future<dynamic> getValue(String key) async {
    _sharedPreference = await SharedPreferences.getInstance();
    final _value = _sharedPreference.getString(key);
    if (_value != null) {
      final _data = json.decode(_value);
      return _data;
    }
    return '';
  }

  Future<bool> setValue(String key, dynamic value) async {
    _sharedPreference = await SharedPreferences.getInstance();
    final _data = json.encode(value);
    return _sharedPreference.setString(key, _data);
  }

  Future<bool> removeValue(String key) async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(key);
  }
}
