import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgapp/src/constants/util.dart';

AppBar customAppBar(BuildContext context, String title,
    {bool isShowingTab = false}) {
  return AppBar(
    bottom: isShowingTab
        ? TabBar(
            labelColor: Loko.blue,
            labelStyle: TextStyle(fontFamily: "GoogleSans Bold"),
            unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: "Evènements",
              ),
              Tab(
                text: "FAQ",
              ),
            ],
          )
        : null,
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.5)),
    actions: <Widget>[
      Container(
        padding: EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.userCircle,
            color: Loko.blue,
            size: 32,
          ),
          onPressed: () {
            Utils.showConnection(context);
          },
        ),
      )
    ],
    titleSpacing: 0,
    title: Text(
      "$title",
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'GoogleSans Medium',
        fontSize: 18,
      ),
    ),
    backgroundColor: Colors.white,
  );
}

// List<Widget> _buildTabs() {
//   return <Widget>[
//     Tab(text: "One"),
//     Tab(text: "Two"),
//     Tab(text: "Three"),
//   ];
// }
