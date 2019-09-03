import 'package:flutter/material.dart';
import 'package:flutter_git/common/model.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:provider/provider.dart' as provider;

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // 移除顶部 padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),  // 构建抽屉菜单头部
            Expanded(child: _buildMenus()),  // 构建功能菜单
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return provider.Consumer<UserModel>(
      builder: (BuildContext context, UserModel user, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipOval(
                    child: user.isLogin
                      ? Image.asset('assets/images/avatar_default.png', width: 80)
                      : Image.asset('assets/images/avatar_default.png', width: 80),
                  ),
                ),
                Text(
                  user.isLogin
                    ? user.user.login
                    : AppLocalizations.of(context).currentLocale.login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!user.isLogin) {
              Navigator.of(context).pushNamed('/login');
            }
          },
        );
      },
    );
  }

  Widget _buildMenus() {
    return provider.Consumer<UserModel>(
      builder: (BuildContext context, UserModel user, Widget child) {
        var _currentLocale = AppLocalizations.of(context).currentLocale;

        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(_currentLocale.theme),
              onTap: () => Navigator.of(context).pushNamed('/theme'),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(_currentLocale.language),
              onTap: () => Navigator.of(context).pushNamed('/language'),
            ),
          ],
        );
      },
    );
  }
}
