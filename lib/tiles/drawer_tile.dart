import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
        pageController.jumpToPage(page);
      },
      icon: Icon(
        icon,
        color: pageController.page.round() == page
            ? Theme.of(context).primaryColor
            : Colors.black,
      ),
    );
  }
}
