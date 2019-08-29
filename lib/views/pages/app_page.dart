import 'package:flutter/material.dart';
import 'package:flutter_git/views/widgets/app_drawer.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {

        },
      ),
    );
  }
}
