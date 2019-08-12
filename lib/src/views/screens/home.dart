import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:gdgapp/src/constants/util.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/screens/programmation.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return SafeArea(
      child: Scaffold(
          drawer: CustomDrawer(),
          appBar: customAppBar(context, "${_provider.title}",
              isShowingTab: _provider.isShowingTab),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 20),
                    child: Image.asset("images/DevFest.png"),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("PROGRAMMATION",
                            style: TextStyle(
                                fontSize: 18, fontFamily: "GoogleSans Bold")),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              _provider.setPage(1);
                            },
                            child: Text(
                              "Afficher tous les évènements",
                              style: TextStyle(
                                  color: Loko.blue,
                                  fontFamily: "GoogleSans Bold"),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 30),
                          child: Text("ANNONCES",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "GoogleSans Bold")),
                        ),
                        MainContainer()
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('annonces').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            return Container(
              child: new Column(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new AnnounceCard(
                      title: document["title"],
                      description: document["description"]);
                }).toList(),
              ),
            );
        }
      },
    );
  }
}

class AnnounceCard extends StatelessWidget {
  final String title;
  final String description;

  AnnounceCard({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Loko.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(fontFamily: "GoogleSans Bold", fontSize: 16),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Text("$description")
        ],
      ),
    );
  }
}
