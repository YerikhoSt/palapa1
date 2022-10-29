import 'package:flutter/material.dart';
import 'package:palapa1/utils/localization/custom_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this function is to convert key string of active language values;
//example : getTranslated(context,'first_string');
// - context : is the BuildContext where the function is called
// - 'first_string' : is String key from active language json/map (from file assets/lang/<languagecode>.json)
String? getTranslated(BuildContext context, String key) =>
    CustomLocalizations.of(context)!.translate(key);

//variable that defined language code for preferences
const String languageCode = 'languageCode';

//this function to set language code preferences to active one
Future<void> setLocale(String language) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(languageCode, language);
  return;
}

//this function to get language code Locale class from active one
Future<Locale?> getLocale() async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (_prefs.getString(languageCode) == null) {
    //by default get locale from device;
    return null;
  } else {
    return Locale(_prefs.getString(languageCode)!.split('_')[0],
        _prefs.getString(languageCode)!.split('_')[1]);
  }
}
