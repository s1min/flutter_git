import 'package:flutter/material.dart';
import 'package:flutter_git/i18n/app_localizations.dart';
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

  void _handleItemTap(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _defaultColor = Colors.grey;
    final _activeColor = Theme.of(context).primaryColor;
    var _currentLocale = AppLocalizations.of(context).currentLocale;

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
            title: Text(_currentLocale.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text(_currentLocale.trend),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(_currentLocale.my),
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
