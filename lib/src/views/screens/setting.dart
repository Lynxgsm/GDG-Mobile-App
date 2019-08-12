import 'package:flutter/material.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: customAppBar(context, "${_provider.title}",
          isShowingTab: _provider.isShowingTab),
    );
  }
}
