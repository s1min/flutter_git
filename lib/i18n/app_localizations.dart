import 'package:flutter/material.dart';

import 'language_base.dart';
import 'languages/en_US.dart';
import 'languages/zh_CN.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  final Map<String, LanguageBase> _localizations = {
    'en': ENUS(),
    'zh': ZHCN(),
  };

  static AppLocalizations of(BuildContext context) => Localizations.of(context, AppLocalizations);

  LanguageBase get currentLocale => _localizations[locale.languageCode];

  get trend => currentLocale.trend;

  get theme => currentLocale.theme;

  get language => currentLocale.language;
}
