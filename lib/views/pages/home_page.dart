import 'package:flutter/material.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
import 'package:flutter_git/views/widgets/app_bar_search.dart';

import '../../common/model.dart';

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
        removeTop: true,
        context: context,
        child: NotificationListener(
          onNotification: (scrollNotification) {
            print(scrollNotification);
          },
          child: ListView(
            children: <Widget>[
              // 头部搜索栏
              Container(
                height: 100,
                padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0,2.0),
                      blurRadius: 4.0
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Builder(builder: (context) {
                            return IconButton(
                              icon: Image.asset(
                                'assets/images/avatar_default.png', 
                                width: 32, 
                                height: 32,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                                widget.onPressedAppBarAvatar(context);
                              },
                            );
                          })
                        ),
                        Expanded( 
                          flex: 4,
                          child: Container(
                            height: 28,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0),
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '搜索',
                                  style: TextStyle(color: Color(0xff6a737d)),
                                ),
                                Icon(
                                  Icons.search,
                                  color: Color(0xff6a737d),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
