import 'package:flutter/material.dart';
import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _color = Theme.of(context).primaryColor;
    var _localeModel = Provider.of<LocaleModel>(context);
    var _locale = AppLocalizations.of(context).currentLocale;

    // 构建语言选择项
    Widget _buildLanguageItem(String lang, value) {
      return ListTile(
        title: Text(
          lang,
          // 对 App 当前语言进行高亮显示
          style: TextStyle(color: _localeModel.locale == value ? _color : null),
        ),
        trailing: _localeModel.locale == value ? Icon(Icons.done, color: _color) : null,
        onTap: () {
          // 更新 locale 后 MaterialApp 会重新 build
          _localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_locale.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem('简体中文', 'zh_CN'),
          _buildLanguageItem('English', 'en_US'),
          _buildLanguageItem(_locale.auto, null),
        ],
      ),
    );
  }
}
