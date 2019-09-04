import 'package:flutter/material.dart';
import 'package:flutter_git/i18n/app_localizations.dart';

import 'package:flutter_git/common/model.dart';
import 'package:flutter_git/views/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.onPressedAppBarAvatar}) : super(key: key);

  final ValueChanged onPressedAppBarAvatar;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: NotificationListener(
          onNotification: (scrollNotification) {},
          child: ListView(
            children: <Widget>[
              _buildHeader(),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  // 头部搜索栏
  Widget _buildHeader() {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 40, right: 20, left: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Image.asset(
                      'assets/images/avatar_default.png',
                      width: 32,
                      height: 32,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/search');
                  },
                  child: Container(
                    height: 28,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Color(0xff6a737d),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .currentLocale
                              .search_placeholder,
                          style: TextStyle(color: Color(0xff6a737d)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 主体列表
  Widget _buildBody() {
    return Container();
  }
}
