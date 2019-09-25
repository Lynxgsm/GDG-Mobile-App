import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgapp/src/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

void _handleSignIn() async {
  print("=================================================================");
  print("Signin");
  print("=================================================================");
  final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn().catchError((onError) {
    print(onError);
  });
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication.catchError((onError) {
    print(onError);
  });

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);

  print("=================================================================");
  print(user);
  print("=================================================================");

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  print('signInWithGoogle succeeded: ${user.email}');
}

final List<String> days = [
  "",
  "Lun.",
  "Mar.",
  "Mer.",
  "Jeu.",
  "Ven.",
  "Sam.",
  "Dim.",
];

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

  static String getDay(String time) {
    var separate = time.split(' ');
    var temps = separate[0].split('-');
    temps = temps.reversed.toList();
    var date =
        DateTime(int.parse(temps[2]), int.parse(temps[1]), int.parse(temps[0]))
            .weekday;
    print(date);
    return days[date] + ' ${temps[0]} oct';
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
                    _handleSignIn();
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
