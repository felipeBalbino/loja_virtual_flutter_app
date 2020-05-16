import 'package:cloud_firestore/cloud_firestore.dart';

import 'menu_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;
  int quantity;
  String size;

  MenuData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid =  document.documentID;
    category =document.data["cardapio"];
    pid = document.data["pid"];
    quantity =  document.data["quantity"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap(){
    return{
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "size":size,
      /*"product":productData.toResumeMap()*/
    };
  }

  String realPrice(){
    for(final key in productData.prices.keys){
      if(key == size){
        return productData.prices[key].toStringAsFixed(2);
      }
    }
  }




}
