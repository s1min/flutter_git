import 'package:flutter/material.dart';
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
  final _activeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          TrendPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              '首页',
              style: TextStyle(color: _currentIndex == 0 ? _activeColor : _defaultColor)
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up, color: _defaultColor),
            activeIcon: Icon(Icons.trending_up, color: _activeColor),
            title: Text(
              '趋势',
              style: TextStyle(color: _currentIndex == 1 ? _activeColor : _defaultColor)
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              '我的',
              style: TextStyle(color: _currentIndex == 2 ? _activeColor : _defaultColor)
            )
          ),
        ],
      ),
    );
  }
}
