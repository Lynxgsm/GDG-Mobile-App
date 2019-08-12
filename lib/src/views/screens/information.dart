import 'package:flutter/material.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/screens/events.dart';
import 'package:gdgapp/src/views/screens/faq.dart';
import 'package:gdgapp/src/views/widgets/customAppBar.dart';
import 'package:gdgapp/src/views/widgets/customDrawer.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NavigationProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "GoogleSans"),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: CustomDrawer(),
          appBar: customAppBar(context, "${_provider.title}",
              isShowingTab: _provider.isShowingTab),
          body: TabBarView(
            children: <Widget>[EventScreen(), FAQScreen()],
          ),
        ),
      ),
    );
  }
}
