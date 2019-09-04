import 'package:flutter/material.dart';
import 'package:flutter_git/views/pages/app_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:flutter_git/i18n/app_localizations_delegate.dart';
import 'package:flutter_git/views/pages/index.dart';
import 'package:provider/provider.dart' as provider;

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        provider.ChangeNotifierProvider.value(value: ThemeModel()),
        provider.ChangeNotifierProvider.value(value: UserModel()),
        provider.ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder:
          (BuildContext context, themeModel, localeModel, Widget child) {
        return MaterialApp(
          home: AppPage(),
          theme: ThemeData(
            primaryColor: themeModel.theme,
          ),
          locale: localeModel.getLocale(),
          supportedLocales: [
            const Locale('en', 'US'), // 美国英语
            const Locale('zh', 'CN'), // 中文简体
          ],
          localizationsDelegates: [
            // 本地化的代理类
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizationsDelegate.delegate,
          ],
          localeResolutionCallback:
              (Locale _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              // 如果已经选定语言，则不跟随系统
              return localeModel.getLocale();
            } else {
              Locale locale;
              // APP 语言跟随系统语言，如果系统语言不是中文简体或美国英语则默认使用美国英语
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                locale = Locale('en', 'US');
              }
              return locale;
            }
          },
          // 注册命名路由表
          routes: <String, WidgetBuilder>{
            '/login': (context) => LoginPage(),
            '/theme': (context) => ThemePage(),
            '/language': (context) => LanguagePage(),
            '/search': (context) => SearchIndexPage()
          },
        );
      }),
    );
  }
}
