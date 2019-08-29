import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/http/api.dart';
import 'package:flutter_git/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供五套可选主题色
const THEME = <Color>[
  Color(0xFF24292e),
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<Color> get theme => THEME;

  // 是否为 release 版
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  // 初始化全局信息，会在 APP 中启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 初始化网络请求相关设置
    Api.init();
  }

  // 持久化 Profile 信息
  static saveProfile() => _prefs.setString('profile', jsonEncode(profile.toJson()));

}
