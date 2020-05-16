import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/screens/signin_screen.dart';
import 'package:lojavirtualflutterapp/screens/signup_screen.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab( icon: Text("Existing"),),
              Tab( icon: Text("New"),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SignInScreen(),
            SignUpScreen()
          ],
        ),
      ),
    );
  }
}
