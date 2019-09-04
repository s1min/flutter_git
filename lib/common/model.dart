import 'package:flutter/material.dart';
import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); // 保存 Profile 变更
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP 是否登录（如果有用户信息，则证明登录过）
  bool get isLogin => user != null;

  // 用户信息发生变化，更新用户信息并通知依赖它的子酸 Widget 更新
  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  Color get theme => Global.theme.firstWhere((e) => e.value == _profile.theme,
      orElse: () => Global.theme[0]);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(Color color) {
    if (color != theme) {
      _profile.theme = color.value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的 APP 语言配置 Locale 类，如果为 null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    // locale 的格式：`zh_CN`
    var t = _profile.locale.split('_');
    return Locale(t[0], t[1]);
  }

  // 获取当前 Locale 的字符串表示
  String get locale => _profile.locale;

  // 用户改变 APP 语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
