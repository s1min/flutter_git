import 'package:flutter/material.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:flutter_git/views/widgets/app_bar_search.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    @required this.onPressedAppBarAvatar
  }): super(key: key);

  final ValueChanged onPressedAppBarAvatar;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        child: AppBar(

          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Image.asset('assets/images/avatar_default.png', width: 40),
                onPressed: () {
                  widget.onPressedAppBarAvatar('123');
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
