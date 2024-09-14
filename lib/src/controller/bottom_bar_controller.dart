import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import '../models/splash_model.dart';

class BottomBarListController extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
