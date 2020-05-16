import 'package:cloud_firestore/cloud_firestore.dart';

class MenuData{
  String category;
  String id;
  String title;
  String description;
  List images;
  Map<dynamic,dynamic> prices;

  MenuData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    prices = snapshot.data["prices"];
    images = snapshot.data["images"];
  }

  String lowerValue(String sized){
    if(sized == null){
      if(prices.length == 1){
        return "R\$ ${prices.values.first.toStringAsFixed(2)}";
      }else {
        for (String key in prices.keys) {
          if (key == 'P') {
            return "a partir de R\$ ${prices[key].toStringAsFixed(2)}";
          }
        }
      }
    }else{
      return "R\$ ${prices[sized]}";
    }

  }

  Map<String, dynamic> toResumeMap(){
    return {
      "title":title,
      "description":description,
      "prices":prices
    };
  }
}