import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutterapp/datas/menu_data.dart';
import 'package:lojavirtualflutterapp/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("cardapio").document(snapshot.documentID).collection("items").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
                MenuData data = MenuData.fromDocument(snapshot.data.documents[index]);
                data.category = this.snapshot.documentID;
                return  Text(
                  data.title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                );
              }
          );
        }
      },
    );
  }
}
