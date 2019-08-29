import 'package:flutter/material.dart';

import 'language_base.dart';
import 'languages/en_US.dart';
import 'languages/zh_CN.dart';

class AppLocalizations {
  final Locale locale;

  final Map<String, LanguageBase> _localizations = {
    'en': ENUS(),
    'zh': ZHCN()
  };

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  LanguageBase get currentLocale {
    return _localizations[locale.languageCode];
  }
}
