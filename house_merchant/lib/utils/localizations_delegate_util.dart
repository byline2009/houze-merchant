import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'localizations_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class LocalizationsDelegateUtil extends LocalizationsDelegate<LocalizationsUtil> {
  const LocalizationsDelegateUtil();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<LocalizationsUtil> load(Locale locale) {
    return new SynchronousFuture<LocalizationsUtil>(new LocalizationsUtil(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationsUtil> old) => false;
}
