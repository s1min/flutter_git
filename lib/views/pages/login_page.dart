import 'package:flutter/material.dart';
import 'package:flutter_git/common/index.dart';
import 'package:flutter_git/http/api.dart';
import 'package:flutter_git/models/index.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:flutter_git/common/global.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool showPassword = false;
  GlobalKey formKey = new GlobalKey<FormState>();
  bool nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    usernameController.text = Global.profile.lastLogin;
    if (usernameController.text != null) {
      nameAutoFocus = false;
    }
    super.initState();
  }

  void onToggleShowPassword() {
    setState(() {
      this.showPassword = !this.showPassword;
    });
  }

  void onLogin() async {
    if ((formKey.currentState as FormState).validate()) {
      User user;

      try {
        user = await Api(context).login(usernameController.text, passwordController.text);
        // 因为登录页返回后，首页会 build，所以传 false，更新 user 后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          showToast(AppLocalizations.of(context).currentLocale.login_fail);
        } else {
          showToast(e.toString());
        }
      } finally {
        Navigator.of(context).pop();
      }

      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }

  void showToast(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    var _currentLocale = AppLocalizations.of(context).currentLocale;

    return Scaffold(
      appBar: AppBar(title: Text(_currentLocale.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                autofocus: nameAutoFocus,
                decoration: InputDecoration(
                  labelText: _currentLocale.username_email,
                )
              ),
              TextFormField(
                controller: passwordController,
                autofocus: !nameAutoFocus,
                decoration: InputDecoration(
                  labelText: _currentLocale.password,
                  suffixIcon: IconButton(
                    icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: onToggleShowPassword,
                  )
                ),
                obscureText: !showPassword,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: onLogin,
                    textColor: Colors.white,
                    child: Text(_currentLocale.login),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
