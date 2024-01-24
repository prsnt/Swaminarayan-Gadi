import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageNotifier extends ChangeNotifier {
  Locale appLocale = const Locale('en');

  Future<void> fetchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      appLocale = const Locale('en');
      return;
    }
    appLocale = Locale(prefs.getString('language_code').toString());
  }

  Future<void> changeLanguage(Locale type) async {
    final prefs = await SharedPreferences.getInstance();
    if (appLocale == type) {
      return;
    }
    if (type == const Locale('hi')) {
      appLocale = const Locale('hi');
      await prefs.setString('language_code', 'hi');
      await prefs.setString('countryCode', '');
    } else {
      appLocale = const Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
