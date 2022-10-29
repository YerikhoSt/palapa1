import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//this class is main class localization
class CustomLocalizations {
  //default locale variable
  final Locale locale;

  late Map<String, String> _localizedValues;

  //constructor class
  CustomLocalizations(this.locale);

  //context class
  static CustomLocalizations? of(BuildContext context) =>
      Localizations.of<CustomLocalizations>(context, CustomLocalizations);

  //delegate function
  static const LocalizationsDelegate<CustomLocalizations> delegate =
      _CustomLocalizationsDelegate();

  //function to load json/map language from json file on assets
  Future<bool> load() async {
    final String jsonString =
        await rootBundle.loadString('assets/lang/${locale.toString()}.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    _localizedValues = jsonMap.map((String key, dynamic value) =>
        MapEntry<String, String>(key, value.toString()));
    return true;
  }

  //function to translate from one language to other language
  String? translate(String key) => _localizedValues[key];
}

//delegate class
class _CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  //constructor class
  const _CustomLocalizationsDelegate();

  //checking supported locale
  @override
  bool isSupported(Locale locale) =>
      <String>['en_US', 'id_ID'].contains(locale.toString());

  //load locale
  @override
  Future<CustomLocalizations> load(Locale locale) async {
    final CustomLocalizations localizations = CustomLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  //reload new locale
  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}
