import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/sharedpref/constants/preferences.dart';
import '../data/sharedpref/shared_preference_helper.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  late final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    final String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class Application {
  factory Application() {
    return _application;
  }

  Application._internal();

  static final Application _application = Application._internal();

  final List<String> supportedLanguages = ['English', 'Spanish'];

  final List<String> supportedLanguagesCodes = ['en', 'es'];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ''));

  Future<Locale?> fetchLocale() async {
    final langCode = await SharedPreferenceHelper()
            .getValue(Preferences.languageCode) as String;
    if (langCode.isEmpty) {
      return const Locale('en', 'en');
    }
    return Locale(langCode, langCode);
  }

  Future<void> saveDeviceLocale(Locale locale) async {
    final langCode = locale.languageCode;
    await SharedPreferenceHelper()
        .setValue(Preferences.languageCode, locale.languageCode);
    print('Saved Language Code : $langCode');
  }
}

Application application = Application();
