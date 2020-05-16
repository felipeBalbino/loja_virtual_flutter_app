import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatefulWidget {
  int _currentIndex;
  PageController _pageController;
  CustomDrawer(this._pageController,this._currentIndex);

  @override
  _CustomDrawerState createState() => _CustomDrawerState(_pageController,this._currentIndex);
}

class _CustomDrawerState extends State<CustomDrawer> {

  PageController _pageController;
  int _currentIndex;
  _CustomDrawerState(this._pageController,this._currentIndex);

  @override
  Widget build(BuildContext context) {
    return  BottomNavyBar(
      selectedIndex: _currentIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Theme.of(context).primaryColor,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            activeColor: Theme.of(context).primaryColor
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Person'),
            activeColor: Theme.of(context).primaryColor
        )
      ],
    );
  }
}
