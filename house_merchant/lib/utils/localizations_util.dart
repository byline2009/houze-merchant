
import 'package:flutter/material.dart';

class LocalizationsUtil {

  static Map<String, Map<String, String>> localizedValues = {
    'en': {},
    'vi': {},
  };

  LocalizationsUtil(this.locale);

  Locale locale;

  /// Call in screen to use.
  static LocalizationsUtil of(BuildContext context) {
    return Localizations.of<LocalizationsUtil>(context, LocalizationsUtil);
  }

  static Future<LocalizationsUtil> load(Locale locale) async {
    LocalizationsUtil appTranslations = LocalizationsUtil(locale);
    return appTranslations;
  }

  String translate(key) {
    return localizedValues[locale.languageCode][key] ?? key;
  }

}
