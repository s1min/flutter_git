import 'package:flutter/material.dart';

class AppBarSearch extends StatefulWidget {
  AppBarSearch({
    Key key,
    @required this.onPressedAvatar
  }): super(key: key);

  final ValueChanged onPressedAvatar;

  @override
  _AppBarSearchState createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {

  void _handlePressedAvatar() {
    widget.onPressedAvatar('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
