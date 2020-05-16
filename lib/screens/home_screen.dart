import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          height: 50,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Latest',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: Align(
            child: _getCarousel(context),
          ),
        ),
        SizedBox(
          height: 50,
          child: Align(
            child: _getCategory(context),
          ),
        ),
      ],
    );
  }

  _getCategory(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 50,
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("cardapio").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              snapshot.data.documents.toList()[index]["icon"]),
                        ),
                        Text(snapshot.data.documents.toList()[index]["title"])
                      ],
                    ));
              },
            );
          }
        },
      ),
    );
  }

  _getCarousel(context) {
    return FutureBuilder<QuerySnapshot>(
      future:
          Firestore.instance.collection("home").orderBy("pos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 200.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else {
          return ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(
              snapshot.data.documents.length,
              (index) => Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 200.0,
                    margin: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data.documents[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  _getProducts(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 50,
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("cardapio").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data.documents.toList()[index]["title"]),
                      CategoryScreen(snapshot.data.documents[index])
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  _getItemsProducts(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 50,
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("cardapio").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Text(snapshot.data.documents.toList()[index]["title"])
                      ],
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
