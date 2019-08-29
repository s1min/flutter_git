import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return new SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}
