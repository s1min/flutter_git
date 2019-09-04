import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/http/api.dart';
import 'package:flutter_git/models/index.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:flutter_git/common/global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _showPassword = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _usernameController.text = Global.profile.lastLogin;
    if (_usernameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  void _showToast(String str) {
    Fluttertoast.showToast(msg: str);
  }

  void _handleLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      User user;

      try {
        user = await Api(context)
            .login(_usernameController.text, _passwordController.text);
        // 因为登录页返回后，首页会 build，所以传 false，更新 user 后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          _showToast(AppLocalizations.of(context).currentLocale.login_fail);
        } else {
          _showToast(e.toString());
        }
      } finally {
        Navigator.of(context).pop();
      }

      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _currentLocale = AppLocalizations.of(context).currentLocale;

    return Scaffold(
      appBar: AppBar(title: Text(_currentLocale.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                autofocus: _nameAutoFocus,
                decoration: InputDecoration(
                  labelText: _currentLocale.username_email,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => v.trim().isNotEmpty
                    ? null
                    : AppLocalizations.of(context)
                        .currentLocale
                        .username_required,
              ),
              TextFormField(
                controller: _passwordController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: _currentLocale.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
                validator: (v) => v.trim().isNotEmpty
                    ? null
                    : AppLocalizations.of(context)
                        .currentLocale
                        .password_required,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _handleLogin,
                    textColor: Colors.white,
                    child: Text(_currentLocale.login),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
