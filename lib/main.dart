import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/models/cart_model.dart';
import 'package:lojavirtualflutterapp/models/user_model.dart';
import 'package:lojavirtualflutterapp/screens/control_screen.dart';
import 'package:lojavirtualflutterapp/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child:ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return  ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Burger Delivery",
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 255, 105, 105),
              ),
              home: SafeArea(child:  ControlScreen(),),
            ),
          );
        },
      ),
    );
  }
}
