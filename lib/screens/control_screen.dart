import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/widgets/custom_drawer.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  static int _currentIndex = 0;
  final _pageController = PageController(initialPage: _currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomDrawer(_pageController, _currentIndex),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          HomeScreen(),
          CartScreen(),
          LoginScreen(),
        ],
      ),
    );
  }
}
