import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/util.dart';
import 'package:gdgapp/src/models/speaker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgrammationDetailScreen extends StatefulWidget {
  final String dateBegin;
  final String dateEnd;
  final String title;
  final String place;
  final String category;
  final String description;
  final String background;
  final List<Speaker> speakers;

  ProgrammationDetailScreen(
      {@required this.title,
      this.dateBegin,
      this.dateEnd,
      this.place,
      this.category,
      this.description,
      this.background,
      this.speakers});
  @override
  _ProgrammationDetailScreenState createState() =>
      _ProgrammationDetailScreenState();
}

class _ProgrammationDetailScreenState extends State<ProgrammationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${widget.background}"))),
        )),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.title}",
                  style:
                      TextStyle(fontFamily: 'GoogleSans Medium', fontSize: 22),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.calendarAlt,
                      size: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                    ),
                    Text(
                      "${Utils.getDay(widget.dateBegin)}, ${Utils.getTime(widget.dateBegin)} - ${Utils.getTime(widget.dateEnd)}",
                      style: TextStyle(fontFamily: 'GoogleSans Medium'),
                    ),
                  ],
                ),
                Text(
                  "${widget.place}",
                  style: TextStyle(fontFamily: 'GoogleSans Medium'),
                ),
                Text(
                  "Débutant",
                  style: TextStyle(fontFamily: 'GoogleSans Medium'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "${widget.description}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontFamily: "GoogleSans Medium"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "INTERVENANTS",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontFamily: "GoogleSans Bold",
                      fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: widget.speakers.map((speaker) {
                    return new Intervenant(
                        url: speaker.imageUrl,
                        name: speaker.name,
                        fonction: speaker.fonction);
                  }).toList(),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.star_border,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class Intervenant extends StatelessWidget {
  final String name;
  final String fonction;
  final String url;
  Intervenant({this.name, this.fonction, this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: NetworkImage("$url"),
      ),
      title: Text(
        "$name",
        style: TextStyle(fontFamily: "GoogleSans Bold", color: Colors.black),
      ),
      subtitle: Text("$fonction"),
    ));
  }
}
