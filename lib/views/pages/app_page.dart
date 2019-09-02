import 'package:flutter/material.dart';
import 'package:flutter_git/common/model.dart';
import 'package:flutter_git/views/pages/index.dart';
import 'package:flutter_git/views/widgets/app_drawer.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;
  final _defaultColor = Colors.grey;
  final _activeColor = ThemeModel().theme;

  void _handleItemTap(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(
            onPressedAppBarAvatar: (context) {
            },
          ),
          TrendPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('趋势')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('我的')
          ),
        ],
        currentIndex: _currentIndex,
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        onTap: _handleItemTap,
      ),
    );
  }
}
