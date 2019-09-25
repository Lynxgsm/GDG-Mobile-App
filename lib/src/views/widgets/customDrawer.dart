import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Image.asset("images/logo.png"),
          ),
          tile("Accueil", FontAwesomeIcons.home, isActive: _provider.page == 0,
              action: () {
            selectAndClose(context, _provider, 0);
          }),
          tile("Programmation", FontAwesomeIcons.calendarDay,
              isActive: _provider.page == 1, action: () {
            selectAndClose(context, _provider, 1);
          }),
          tile("Plan", FontAwesomeIcons.mapMarkerAlt,
              isActive: _provider.page == 2, action: () {
            selectAndClose(context, _provider, 2);
          }),
          Divider(),
          tile("Informations", FontAwesomeIcons.infoCircle,
              isActive: _provider.page == 3, action: () {
            selectAndClose(context, _provider, 3);
          }),
          tile("A propos...", FontAwesomeIcons.cog,
              isActive: _provider.page == 4, action: () {
            selectAndClose(context, _provider, 4);
          }),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/GDG.png",
                width: 200,
              )
            ],
          )
        ],
      ),
    );
  }
}

void selectAndClose(
    BuildContext context, NavigationProvider _provider, int page) {
  Navigator.pop(context);
  Timer(Duration(milliseconds: 100), () {
    _provider.setPage(page);
  });
}

Container tile(String title, IconData icon,
    {bool isActive = false, Function action}) {
  return Container(
    margin: isActive ? EdgeInsets.only(right: 20) : EdgeInsets.zero,
    decoration: isActive
        ? BoxDecoration(
            color: Loko.lightBlue,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)))
        : BoxDecoration(),
    child: ListTile(
      title: Text(
        "$title",
        style: TextStyle(
            color: isActive ? Loko.blue : Colors.black,
            fontFamily: "GoogleSans Medium"),
      ),
      dense: true,
      leading: Icon(
        icon,
        size: 20,
      ),
      onTap: action,
    ),
  );
}
