import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gdgapp/src/constants/util.dart';
import 'package:gdgapp/src/views/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isConnected() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        print(user);
      } else {
        print("no connected user");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isConnected();
    Timer(Duration(seconds: 2), () {
      Utils.goto(context, HomeScreen(), isReplace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          child: Image.asset("images/logo.png")),
    );
  }
}
