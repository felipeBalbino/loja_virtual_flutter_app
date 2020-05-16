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
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            tabs: <Widget>[
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Existing"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("New"),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[SignInScreen(), SignUpScreen()],
        ),
      ),
    );
  }
}
