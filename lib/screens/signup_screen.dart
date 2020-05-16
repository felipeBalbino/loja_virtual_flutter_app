import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cepController = TextEditingController();
  final _numController = TextEditingController();
  final _compController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  bool _isButtonDisabled  = false;

  void setButtonDisabled() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  void setButtonEnabled() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,

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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome Completo"),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Nome Completo inválido!";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
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
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Senha inválida";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: _cepController,
                        decoration: InputDecoration(hintText: "CEP"),
                        validator: (text) {
                          if (text.isEmpty || text.length < 8) {
                            return "CEP inválido!";
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _numController,
                        decoration: InputDecoration(hintText: "Número"),
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Número inválido!";
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _compController,
                  decoration: InputDecoration(hintText: "Complemento"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Complemento inválido!";
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
                              'SIGN UP',
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
                    onPressed:  _isButtonDisabled ? null :() {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "cep": _cepController.text,
                          "num": _numController.text,
                          "comp": _compController.text
                        };
                        setButtonDisabled();
                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                        setButtonEnabled();
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

  void _onSuccess() {
    _scaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Usuário criado com sucesso!",
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Falha ao criar usuário!!",
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );

  }
}
