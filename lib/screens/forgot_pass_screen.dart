import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lojavirtualflutterapp/models/user_model.dart';

import 'package:lojavirtualflutterapp/utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
import 'signin_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 246, 248),
      key: _scaffold,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.back_icon, //change your color here
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: 25,
              color: AppColors.color_title,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background_appBar,
        elevation: 0,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Enter the email address you used to create your account and we will email you a link to reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@")) {
                      return "E-mail inválido!";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'SEND EMAIL',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      if (_emailController.text.isEmpty) {
                        showDefaultSnackBar(
                          context,
                          "Insira seu e-mail para recuperação!",
                          Colors.redAccent,
                        );
                      } else {
                        model.recoverPass(email: _emailController.text);
                        showDefaultSnackBar(
                          context,
                          "Confira seu e-mail!",
                          Colors.green,
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void showDefaultSnackBar(BuildContext context, String text, Color color) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
