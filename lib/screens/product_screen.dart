import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/datas/cart_product.dart';
import 'package:lojavirtualflutterapp/datas/menu_data.dart';
import 'package:lojavirtualflutterapp/models/cart_model.dart';
import 'package:lojavirtualflutterapp/models/user_model.dart';
import 'package:lojavirtualflutterapp/screens/cart_screen.dart';
import 'package:lojavirtualflutterapp/screens/signin_screen.dart';

import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  final MenuData data;

  ProductScreen(this.data);

  @override
  _ProductScreenState createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {
  final MenuData data;
  String _size = "P";

  _ProductScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  data.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  data.lowerValue(_size),
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: data.prices.keys.map((f) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _size = f;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: f == _size ? primaryColor : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: Colors.grey[500], width: 1.0)),
                          width: 50.0,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(f),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: _size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = _size;
                              cartProduct.quantity = 1;
                              cartProduct.pid = data.id;
                              cartProduct.category = data.category;
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
