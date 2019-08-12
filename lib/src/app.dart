import 'package:flutter/material.dart';
import 'package:gdgapp/src/providers/navigation_provider.dart';
import 'package:gdgapp/src/views/screens/content.dart';
import 'package:gdgapp/src/views/screens/home.dart';
import 'package:gdgapp/src/views/screens/splash.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => NavigationProvider(),
      child: MaterialApp(
        title: 'DevFest GDG Antananarivo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "GoogleSans",
          primarySwatch: Colors.blue,
        ),
        home: ContentScreen(),
      ),
    );
  }
}
