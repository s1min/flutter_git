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

  LanguageBase get currentLocale {
    var lc = _localizations.containsKey(locale.languageCode) ?? 'zh';
    print(locale.languageCode);
    print(_localizations['zh']);
    print(_localizations['zh'].home);
    return _localizations[lc];
  }
}
