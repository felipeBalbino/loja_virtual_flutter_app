import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/screens/cart_screen.dart';

class CartButton extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;
  CartButton(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: pageController.page.round() == page
          ? Theme.of(context).primaryColor
          : Colors.black),
      iconSize: 30,
      onPressed: () {
        Navigator.of(context).pop();
        pageController.jumpToPage(page);
      },
    );
  }
}
