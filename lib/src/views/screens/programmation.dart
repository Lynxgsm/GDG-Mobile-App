import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdgapp/src/constants/util.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:provider/provider.dart';

class ProgrammationScreen extends StatefulWidget {
  @override
  _ProgrammationScreenState createState() => _ProgrammationScreenState();
}

class Item {
  String date;
  String title;
  String place;
  CategoryFilter category;

  Item({this.date, this.title, this.place, this.category});
}

class CategoryFilter {
  Color color;
  String category;

  CategoryFilter({this.color, this.category});
}

class _ProgrammationScreenState extends State<ProgrammationScreen> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: customAppBar(context, "${_provider.title}",
            isShowingTab: _provider.isShowingTab),
        body: Container(
          child: Column(
            children: <Widget>[Container(height: 300, child: MainContainer())],
          ),
        ),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('programmes').snapshots(),
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
                  print(document["date"].toDate());
                  return new ProgrammationTile(
                      title: document["title"],
                      date: Utils.getTime(document["date"].toDate().toString()),
                      place: document["place"],
                      category: document["category"]["category"]);
                }).toList(),
              ),
            );
        }
      },
    );
  }
}

class ProgrammationTile extends StatelessWidget {
  final String date;
  final String title;
  final String place;
  final String category;

  ProgrammationTile({this.title, this.date, this.place, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        leading: Text(
          "$date",
          style: TextStyle(color: Loko.blue, fontFamily: "GoogleSans Medium"),
        ),
        title: Text("$title", style: TextStyle(fontFamily: "GoogleSans Bold")),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text("$place"), Text("$category")],
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.star_border),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Color color;
  String category;

  Category({this.color, this.category});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 7,
        ),
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
        Text("$category")
      ],
    );
  }
}
