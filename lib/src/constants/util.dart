import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgapp/src/constants/colors.dart';

class Utils {
  Utils._();

  static goto(BuildContext context, Widget screen, {bool isReplace = false}) {
    isReplace
        ? Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => screen))
        : Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen));
  }

  static String getTime(String time) {
    var separate = time.split(' ');
    var temps = separate[1].split(':');
    temps.removeLast();
    return temps.join(":");
  }

  static void showConnection(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Icon(FontAwesomeIcons.userCircle, color: Loko.blue, size: 36),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  Text("Bienvenue",
                      style: TextStyle(
                          fontSize: 16, fontFamily: "GoogleSans Bold"))
                ]),
                Divider(),
                Text(
                    "Connectez-vous pour enregistrer des événements, réserver des places et noter des sessions (auxquelles vous avez participé). Les actions seront synchronisées entre votre compte, l'application et le site.",
                    style: TextStyle(fontSize: 14)),
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.signInAlt),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                      ),
                      Text('Se connecter')
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
