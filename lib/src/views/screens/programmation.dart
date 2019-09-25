import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdgapp/src/constants/util.dart';
import 'package:gdgapp/src/models/speaker.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/screens/programmationDetails.dart';
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
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(height: 300, child: MainContainer())
                ],
              ),
            )),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('schedules').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              child: new Column(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  List<Speaker> speakers = [];

                  for (var i = 0; i < document["speakers_list"].length; i++) {
                    final Speaker _spk = Speaker(
                        name: document["speakers_list"][i]["name"],
                        imageUrl: document["speakers_list"][i]["photo_url"],
                        fonction: document["speakers_list"][i]["function"]);
                    speakers.add(_spk);
                  }
                  return new ProgrammationTile(
                    background: document["image_url"],
                    title: document["title"],
                    dateBegin: document["date_begin"].toDate().toString(),
                    dateEnd: document["date_end"].toDate().toString(),
                    place: document["room"],
                    description: document["description"],
                    speakers: speakers,
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }
}

class ProgrammationTile extends StatelessWidget {
  final String dateBegin;
  final String dateEnd;
  final String title;
  final String place;
  final String description;
  final String background;
  final List<Speaker> speakers;

  ProgrammationTile(
      {this.title,
      this.dateBegin,
      this.dateEnd,
      this.place,
      this.description,
      this.background,
      this.speakers});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Utils.goto(
              context,
              ProgrammationDetailScreen(
                  title: title,
                  description: description,
                  speakers: speakers,
                  dateBegin: dateBegin,
                  dateEnd: dateEnd,
                  background: background,
                  place: place));
        },
        child: ListTile(
          isThreeLine: true,
          leading: Column(
            children: <Widget>[
              Text(
                Utils.getDay("$dateBegin"),
                style: TextStyle(color: Loko.blue, fontSize: 16),
              ),
              Text(
                Utils.getTime("$dateBegin"),
                style: TextStyle(color: Loko.blue, fontSize: 16),
              )
            ],
          ),
          title:
              Text("$title", style: TextStyle(fontFamily: "GoogleSans Bold")),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text("$place")],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.star_border),
          ),
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
