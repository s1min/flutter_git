import 'package:flutter/material.dart';

class AppBottomAppBar extends StatefulWidget {
  _AppBottomAppBarState createState() => _AppBottomAppBarState();
}

class _AppBottomAppBarState extends State<AppBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.home)),
          IconButton(icon: Icon(Icons.trending_up)),
          IconButton(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
