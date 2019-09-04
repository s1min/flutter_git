import 'package:flutter/material.dart';
import 'package:flutter_git/common/global.dart';
import 'package:flutter_git/common/model.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).currentLocale.theme),
      ),
      body: ListView(
        children: Global.theme.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: () {
              // 主题更新后，MaterialApp 会重新 build
              Provider.of<ThemeModel>(context).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
