import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: MainContainer()),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('faqs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Align(
              alignment: Alignment.center,
              child: new CircularProgressIndicator(),
            );
          default:
            return Container(
              child: new Column(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new FaqItem(
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

_launchURL(String url) async {
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class FaqItem extends StatelessWidget {
  final String title;
  final String description;

  FaqItem({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ExpansionTile(
      title: Text(
        '$title',
        style: TextStyle(fontFamily: 'GoogleSans Bold', color: Loko.blue),
      ),
      children: <Widget>[
        Html(
            data: """$description""",
            defaultTextStyle:
                TextStyle(fontFamily: 'GoogleSans Medium', fontSize: 12),
            padding: EdgeInsets.all(14.0),
            linkStyle: const TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(26, 115, 233, 1)),
            onLinkTap: (url) {
              _launchURL(url);
            })
      ],
    ));
  }
}
