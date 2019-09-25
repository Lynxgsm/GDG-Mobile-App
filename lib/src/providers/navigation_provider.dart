import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdgapp/src/views/screens/about.dart';
import 'package:gdgapp/src/views/screens/home.dart';
import 'package:gdgapp/src/views/screens/information.dart';
import 'package:gdgapp/src/views/screens/map.dart';
import 'package:gdgapp/src/views/screens/programmation.dart';

class NavigationProvider with ChangeNotifier {
  int _page = 0;
  String _title = "Accueil";
  Widget _screen = HomeScreen();
  bool _isShowingTab = false;
  bool _visible = true;

  int get page => _page;
  String get title => _title;
  Widget get screen => _screen;
  bool get isShowingTab => _isShowingTab;
  bool get visible => _visible;

  void setPage(int page) {
    _visible = false;
    notifyListeners();
    _page = page;

    switch (_page) {
      case 0:
        _screen = HomeScreen();
        _title = "Accueil";
        _isShowingTab = false;
        break;
      case 1:
        _screen = ProgrammationScreen();
        _title = "Programmation";
        _isShowingTab = false;
        break;
      case 2:
        _screen = MapScreen();
        _title = "Plan";
        _isShowingTab = false;
        break;
      case 3:
        _screen = InformationScreen();
        _title = "Informations";
        _isShowingTab = true;
        break;
      default:
        _screen = AboutScreen();
        _title = "A propos";
        _isShowingTab = false;
        break;
    }

    notifyListeners();

    Timer(Duration(milliseconds: 500), () {
      _visible = true;
      notifyListeners();
    });
  }
}
