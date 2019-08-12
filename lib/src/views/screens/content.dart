import 'package:flutter/material.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/screens/home.dart';
import 'package:gdgapp/src/views/screens/information.dart';
import 'package:gdgapp/src/views/screens/programmation.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:provider/provider.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return SafeArea(
        child: AnimatedOpacity(
            duration: Duration(milliseconds: _provider.visible ? 500 : 100),
            opacity: _provider.visible ? 1.0 : 0.0,
            child: Scaffold(body: _provider.screen)));
  }
}
